
-- general
vim.opt.relativenumber = true
vim.g.nvim_tree_disable_netrw = false

lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedark"

-- keymappings
lvim.leader = "space"

-- Save
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<ESC>:w<CR>", { noremap = true, silent = true })

-- Buffers
vim.api.nvim_set_keymap("n", "<TAB>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferPrevious<CR>", { noremap = true, silent = true })

-- Which key
lvim.builtin.which_key.mappings["f"] = {"<cmd>Files<CR>", "Find file"}
lvim.builtin.which_key.mappings["l"] = {"<cmd>Rg<CR>", "Live grep"}
lvim.builtin.which_key.mappings["b"] = {
  name = "+Buffers",
  t = {"<cmd>BufferPin<CR>", "Pin buffer"},
  e = {"<cmd>BufferCloseAllButCurrent<CR>", "Close all, but current buffer"},
  r = {"<cmd>BufferCloseAllButPinned<CR>", "Close all, but pinned buffers"},
  j = {"<cmd>BufferPick<CR>", "Jump to buffer"},
  c = {"<cmd>BufferClose<CR>", "Close buffer"},
  D = {"<cmd>BufferOrderByDirectory<CR>", "Order by directory"},
}

lvim.keys.term_mode = {}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true

-- FZF
vim.env.FZF_DEFAULT_COMMAND = 'rg --files'

-- Elixir
lvim.lang.elixir.formatters = {
  {
    exe = "mix",
    args = {"fmt"},
  },
}

-- Additional Plugins
lvim.plugins = {
  {"joshdick/onedark.vim"},
  {"junegunn/fzf", run = "./install --all"},
  {"junegunn/fzf.vim"},
}

