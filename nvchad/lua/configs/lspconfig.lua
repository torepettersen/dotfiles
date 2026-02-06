local nvchad_lsp = require("nvchad.configs.lspconfig")
local mason_dir = os.getenv "HOME" .. "/.local/share/nvchad/mason/"

local elixir_lsp = "elixirls"

-- Set defaults for all LSP servers
vim.lsp.config("*", {
  capabilities = nvchad_lsp.capabilities,
  on_init = nvchad_lsp.on_init,
})

-- Configure tailwindcss
vim.lsp.config("tailwindcss", {
  init_options = {
    userLanguages = {
      elixir = "html-eex",
      eelixir = "html-eex",
      heex = "html-eex",
    },
  },
})

-- Configure Elixir LSP
if elixir_lsp == "lexical" then
  vim.lsp.config("lexical", {
    cmd = { mason_dir .. "packages/lexical/libexec/lexical/bin/start_lexical.sh" },
  })
elseif elixir_lsp == "elixirls" then
  vim.lsp.config("elixirls", {
    cmd = { mason_dir .. "packages/elixir-ls/language_server.sh" },
    settings = {
      dialyzerEnabled = false,
      enableTestLenses = false,
    },
  })
end

-- Enable all servers
vim.lsp.enable({ "lua_ls", "ts_ls", "pyright", "svelte", "tailwindcss", elixir_lsp })
