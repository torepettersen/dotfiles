if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

# --- General tooling ---
set -gx NVIM_APPNAME nvchad
set -gx FLYCTL_INSTALL "$HOME/.fly"

# --- Elixir / Erlang ---
set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx KERL_BUILD_DOCS yes
set -gx MIX_OS_DEPS_COMPILE_PARTITION_COUNT (math (nproc) / 2)

# --- Android / Java ---
set -gx JAVA_HOME /opt/android-studio/jbr
set -gx ANDROID_HOME "$HOME/Android/Sdk"
set -gx NDK_HOME "$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"

# --- PATH updates ---
fish_add_path $FLYCTL_INSTALL/bin
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path /opt/or-tools/lib

/usr/bin/mise activate fish | source

# --- Aliases ---
alias fb="sudo systemctl restart bluetooth.service"
alias lg="lazygit"
alias pg="pg_ctl start >/dev/null 2>&1"
alias phxs="iex -S mix phx.server"
alias yayu="sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist"

# --- PNPM ---
set -gx PNPM_HOME "/home/tore/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
