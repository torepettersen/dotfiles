M = {}

M.options = {
  user_default_options = {
    tailwind = true,
    rgb_fn = true,
    hsl_fn = true,
  },
}

M.setup = function()
  require("colorizer").setup(M.options)

  -- execute colorizer as soon as possible
  vim.defer_fn(function()
    require("colorizer").attach_to_buffer(0)
  end, 0)
end

return M
