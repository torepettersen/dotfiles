local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    elixir = { "elixir-ls" },
  },

  format_on_save = {},
}

require("conform").setup(options)
