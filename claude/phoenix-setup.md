# Phoenix Setup

## Create new project

```bash
mix phx.new APP_NAME
```

Then install dependencies and Ash:

```bash
cd APP_NAME
mix deps.get
mix igniter.install ash ash_phoenix ash_postgres ash_authentication ash_authentication_phoenix live_debugger tidewave usage_rules ash_money --auth-strategy password --setup --yes
```

## Post-igniter setup

### 1. Configure database and Ash settings

In `config/config.exs`, add/update these configs:

```elixir
# Generator timestamps
config :APP_NAME, :generators, timestamp_type: :utc_datetime_usec

# Repo settings - UUIDv7 primary keys with proper timestamps
config :APP_NAME, APP_NAME.Repo,
  migration_primary_key: [type: :uuid, default: {:fragment, "uuid_generate_v7()"}],
  migration_foreign_key: [type: :uuid],
  migration_timestamps: [type: :utc_datetime_usec, default: {:fragment, "now()"}]

# Ash policies
config :ash, :policies,
  no_filter_static_forbidden_reads?: false,
  private_fields: :include
```

### 2. Add helpers to `lib/APP_NAME_web.ex`

Add these functions at the module level (at the end of the module):

```elixir
def ok(socket), do: {:ok, socket}
def ok(socket, attrs), do: {:ok, socket, attrs}
def noreply(socket), do: {:noreply, socket}
def actor(socket), do: socket.assigns.current_user
```

Then in the `live_view` function's quote block, add the import:

```elixir
def live_view do
  quote do
    use Phoenix.LiveView

    import APP_NAMEWeb, only: [ok: 1, ok: 2, noreply: 1, actor: 1]

    unquote(html_helpers())
  end
end
```

### 3. Add authorization bypass to User resource

In `lib/APP_NAME/accounts/user.ex`, add a policy bypass for authentication context:

```elixir
policies do
  bypass context_equals(:authentication?, true) do
    authorize_if always()
  end
  # ... other policies
end
```

### 4. Update AuthController for return_to handling

In `lib/APP_NAME_web/controllers/auth_controller.ex`, find this line:

```elixir
return_to = get_session(conn, :return_to) || ~p"/"
```

Replace with:

```elixir
return_to = conn.params["return_to"] || get_session(conn, :return_to) || ~p"/"
```

### 5. Add auth routes to router

In `lib/APP_NAME_web/router.ex`, add inside the main scope:

```elixir
import AshAuthentication.Phoenix.LiveSession

ash_authentication_live_session :no_user,
  on_mount: {APP_NAMEWeb.LiveUserAuth, :live_no_user} do
  live "/sign-in", AuthLive.SignIn
  live "/register", AuthLive.Registration
  live "/password-reset", AuthLive.PasswordResetRequest
  live "/password-reset/:token", AuthLive.PasswordReset
end
```

### 6. Create custom auth LiveViews

Create these four files:

#### `lib/APP_NAME_web/live/auth_live/sign_in.ex`

```elixir
defmodule APP_NAMEWeb.AuthLive.SignIn do
  use APP_NAMEWeb, :live_view

  alias APP_NAME.Accounts
  alias APP_NAME.Accounts.User
  alias AshPhoenix.Form

  @impl true
  def mount(_params, _session, socket) do
    form = Form.for_action(User, :sign_in_with_password, domain: Accounts, as: "user")

    socket
    |> assign(:form, form)
    |> ok()
  end

  @impl true
  def handle_event("validate", %{"user" => params}, socket) do
    form = Form.validate(socket.assigns.form, params, errors: false)

    socket
    |> assign(form: form)
    |> noreply()
  end

  @impl true
  def handle_event("submit", %{"user" => params}, socket) do
    result =
      Form.submit(socket.assigns.form,
        params: params,
        read_one?: true,
        before_submit: fn changeset ->
          Ash.Changeset.set_context(changeset, %{
            token_type: :sign_in,
            authentication?: true
          })
        end
      )

    case result do
      {:ok, user} ->
        token = user.__metadata__.token

        socket
        |> redirect(to: ~p"/auth/user/password/sign_in_with_token?token=#{token}")
        |> noreply()

      {:error, form} ->
        socket
        |> assign(:form, form)
        |> noreply()
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="mx-auto max-w-sm space-y-4">
        <.header class="text-center">
          <p>Sign in</p>
          <:subtitle>
            Enter your email and password to sign in to your account.
          </:subtitle>
        </.header>

        <.form :let={f} for={@form} id="sign-in-form" phx-submit="submit" phx-change="validate">
          <.input field={f[:email]} type="email" label="Email" autocomplete="username" required />
          <.input
            field={f[:password]}
            type="password"
            label="Password"
            autocomplete="current-password"
          />

          <div class="mb-4 flex justify-between">
            <.link navigate={~p"/password-reset"} class="link link-primary text-sm">
              Forgot your password?
            </.link>
            <.link navigate={~p"/register"} class="link link-primary text-sm">
              Need an account?
            </.link>
          </div>

          <.button class="w-full" variant="primary">
            Sign in <span aria-hidden="true">→</span>
          </.button>
        </.form>
      </div>
    </Layouts.app>
    """
  end
end
```

#### `lib/APP_NAME_web/live/auth_live/registration.ex`

```elixir
defmodule APP_NAMEWeb.AuthLive.Registration do
  use APP_NAMEWeb, :live_view

  alias APP_NAME.Accounts
  alias APP_NAME.Accounts.User
  alias AshPhoenix.Form

  @impl true
  def mount(_params, _session, socket) do
    form = Form.for_create(User, :register_with_password, domain: Accounts, as: "user")

    strategies =
      User
      |> AshAuthentication.Info.authentication_strategies()
      |> Map.new(fn strategy -> {strategy.name, strategy} end)

    socket
    |> assign(:form, form)
    |> assign(:strategies, strategies)
    |> ok()
  end

  @impl true
  def handle_event("validate", %{"user" => params}, socket) do
    form = Form.validate(socket.assigns.form, params, errors: false)

    socket
    |> assign(form: form)
    |> noreply()
  end

  @impl true
  def handle_event("submit", %{"user" => params}, socket) do
    result =
      Form.submit(socket.assigns.form,
        params: params,
        read_one?: true,
        before_submit: fn changeset ->
          Ash.Changeset.set_context(changeset, %{
            token_type: :sign_in,
            authentication?: true
          })
        end
      )

    case result do
      {:ok, user} ->
        token = user.__metadata__.token

        socket
        |> redirect(to: ~p"/auth/user/password/sign_in_with_token?token=#{token}")
        |> noreply()

      {:error, form} ->
        socket
        |> assign(:form, form)
        |> noreply()
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="mx-auto max-w-sm space-y-3">
        <.header class="text-center">
          Register
          <:subtitle>
            Enter your email and password to register an account.
          </:subtitle>
        </.header>

        <.form :let={f} for={@form} id="register-form" phx-submit="submit" phx-change="validate">
          <.input field={f[:email]} type="email" label="Email" autocomplete="username" required />
          <.input
            field={f[:password]}
            type="password"
            label="Password"
            autocomplete="current-password"
          />
          <.input
            :if={@strategies.password.confirmation_required?}
            field={f[:password_confirmation]}
            type="password"
            label="Password confirmation"
            autocomplete="current-password"
          />

          <div class="mb-3 flex justify-between">
            <.link navigate={~p"/sign-in"} class="link link-primary text-sm">
              Already have an account?
            </.link>
            <.link navigate={~p"/password-reset"} class="link link-primary text-sm">
              Forgot your password?
            </.link>
          </div>

          <.button class="w-full" variant="primary">
            Register <span aria-hidden="true">→</span>
          </.button>
        </.form>
      </div>
    </Layouts.app>
    """
  end
end
```

#### `lib/APP_NAME_web/live/auth_live/password_reset_request.ex`

```elixir
defmodule APP_NAMEWeb.AuthLive.PasswordResetRequest do
  use APP_NAMEWeb, :live_view

  alias APP_NAME.Accounts
  alias APP_NAME.Accounts.User
  alias AshPhoenix.Form

  @impl true
  def mount(_params, _session, socket) do
    form = Form.for_action(User, :request_password_reset, domain: Accounts, as: "user")

    socket
    |> assign(:form, form)
    |> ok()
  end

  @impl true
  def handle_event("validate", %{"user" => params}, socket) do
    form = Form.validate(socket.assigns.form, params, errors: false)

    socket
    |> assign(form: form)
    |> noreply()
  end

  @impl true
  def handle_event("submit", %{"user" => params}, socket) do
    result =
      Form.submit(socket.assigns.form,
        params: params,
        read_one?: true,
        before_submit: fn changeset ->
          Ash.Changeset.set_context(changeset, %{
            token_type: :password_reset,
            authentication?: true
          })
        end
      )

    case result do
      {:ok, _user} ->
        socket
        |> put_flash(:info, "If an account with that email exists, you will receive a password reset email.")
        |> redirect(to: ~p"/sign-in")
        |> noreply()

      {:error, form} ->
        socket
        |> assign(:form, form)
        |> noreply()
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="mx-auto max-w-sm space-y-4">
        <.header class="text-center">
          <p>Reset password</p>
          <:subtitle>
            Enter your email address and we will send you a link to reset your password.
          </:subtitle>
        </.header>

        <div :if={local_mail_adapter?()} class="alert alert-info">
          <.icon name="hero-information-circle" class="size-6 shrink-0" />
          <div>
            <p>You are running the local mail adapter.</p>
            <p>
              To see sent emails, visit <.link href="/dev/mailbox" class="underline" target="_blank">the mailbox page</.link>.
            </p>
          </div>
        </div>

        <.form :let={f} for={@form} id="password-reset-request-form" phx-submit="submit" phx-change="validate">
          <.input field={f[:email]} type="email" label="Email" autocomplete="username" required />

          <div class="mb-4 flex justify-between">
            <.link navigate={~p"/sign-in"} class="link link-primary text-sm">
              Back to sign in
            </.link>
            <.link navigate={~p"/register"} class="link link-primary text-sm">
              Need an account?
            </.link>
          </div>

          <.button class="w-full" variant="primary">
            Send password reset email <span aria-hidden="true">→</span>
          </.button>
        </.form>
      </div>
    </Layouts.app>
    """
  end

  defp local_mail_adapter? do
    # Update APP_NAME here to match your app
    Application.get_env(:APP_NAME, APP_NAME.Mailer)[:adapter] == Swoosh.Adapters.Local
  end
end
```

#### `lib/APP_NAME_web/live/auth_live/password_reset.ex`

```elixir
defmodule APP_NAMEWeb.AuthLive.PasswordReset do
  use APP_NAMEWeb, :live_view

  alias APP_NAME.Accounts
  alias APP_NAME.Accounts.User
  alias AshPhoenix.Form

  @impl true
  def mount(%{"token" => token}, _session, socket) do
    form = Form.for_action(User, :reset_password, domain: Accounts, as: "user")

    socket
    |> assign(:form, form)
    |> assign(:token, token)
    |> ok()
  end

  @impl true
  def handle_event("validate", %{"user" => params}, socket) do
    form = Form.validate(socket.assigns.form, params, errors: false)

    socket
    |> assign(form: form)
    |> noreply()
  end

  @impl true
  def handle_event("submit", %{"user" => params}, socket) do
    result =
      Form.submit(socket.assigns.form,
        params: params,
        read_one?: true,
        before_submit: fn changeset ->
          Ash.Changeset.set_context(changeset, %{
            token: socket.assigns.token,
            token_type: :password_reset,
            authentication?: true
          })
        end
      )

    case result do
      {:ok, _user} ->
        socket
        |> put_flash(:info, "Password reset successfully. Please sign in with your new password.")
        |> redirect(to: ~p"/sign-in")
        |> noreply()

      {:error, form} ->
        socket
        |> assign(:form, form)
        |> noreply()
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="mx-auto max-w-sm space-y-4">
        <.header class="text-center">
          <p>Reset password</p>
          <:subtitle>
            Enter your new password below.
          </:subtitle>
        </.header>

        <.form :let={f} for={@form} id="password-reset-form" phx-submit="submit" phx-change="validate">
          <.input
            field={f[:password]}
            type="password"
            label="New password"
            autocomplete="new-password"
          />
          <.input
            field={f[:password_confirmation]}
            type="password"
            label="Confirm new password"
            autocomplete="new-password"
          />

          <div class="mb-4 flex justify-between">
            <.link navigate={~p"/sign-in"} class="link link-primary text-sm">
              Back to sign in
            </.link>
          </div>

          <.button class="w-full" variant="primary">
            Reset password <span aria-hidden="true">→</span>
          </.button>
        </.form>
      </div>
    </Layouts.app>
    """
  end
end
```

## Notes

- Replace all instances of `APP_NAME` with your actual app module name (e.g., `Vibe`)
- Replace all instances of `APP_NAMEWeb` with your web module (e.g., `VibeWeb`)
- The templates use `Layouts.app` - adjust if your layout structure differs
- The templates use Tailwind classes like `link-primary` and `alert-info` (DaisyUI style) - adjust for your CSS setup
- The `local_mail_adapter?` function in password_reset_request.ex needs the app name updated
