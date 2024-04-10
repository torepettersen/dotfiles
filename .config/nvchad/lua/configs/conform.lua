local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    json = { "prettierd" },
    elixir = { "elixir-ls" },
    javascript = { "prettierd" },
  },

  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
}

require("conform").setup(options)
