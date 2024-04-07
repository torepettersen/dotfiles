local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd", "rustywind" },
    elixir = { "elixir-ls", "rustywind" },
    javascript = { "prettierd" },
  },

  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
}

require("conform").setup(options)
