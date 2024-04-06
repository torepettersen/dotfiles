local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local elixir_lsp = "elixirls"
local servers = { "lua_ls", "html", "cssls", "tsserver" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    capabilities = capabilities,
  }
end

local mason_dir = os.getenv "HOME" .. "/.local/share/nvchad/mason/"

if elixir_lsp == "lexical" then
  lspconfig.lexical.setup {
    on_init = on_init,
    capabilities = capabilities,
    cmd = { mason_dir .. "packages/lexical/libexec/lexical/bin/start_lexical.sh" },
    settings = {},
  }
elseif elixir_lsp == "elixirls" then
  lspconfig.elixirls.setup {
    on_init = on_init,
    capabilities = capabilities,
    cmd = { mason_dir .. "packages/elixir-ls/language_server.sh" },
    settings = {
      dialyzerEnabled = false,
      enableTestLenses = false,
    },
    on_attach = function(client, bufnr)
      require("core.utils").load_mappings("elixir", { buffer = bufnr })
    end,
  }
end
