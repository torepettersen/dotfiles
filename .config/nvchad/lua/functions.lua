local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
local neotest = require "neotest"

local M = {}

M.lazygit = function()
  lazygit:toggle()
end

M.tests = {
  run = function()
    neotest.run.run()
  end,
  run_file = function()
    neotest.run.run(vim.fn.expand "%")
  end,
  toggle_summary = function()
    neotest.summary.toggle()
  end,
  show_output = function()
    neotest.output.open { enter = true }
  end,
  stop = function()
    neotest.run.stop()
  end,
}

return M
