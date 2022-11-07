-- general
vim.opt.relativenumber = true

lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedark"

-- keymappings
lvim.leader = "space"

-- Save
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.insert_mode["<C-s>"] = "<ESC>:w<CR>"

-- Buffers
lvim.keys.normal_mode["<TAB>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-TAB>"] = ":bprevious<CR>"

-- Telescope
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Which key
lvim.builtin.which_key.mappings["l"] = { "<cmd>Telescope live_grep<cr>", "Live grep" }
lvim.builtin.which_key.mappings["b"] = {
  name = "+Buffers",
  t = { "<cmd>BufferPin<CR>", "Pin buffer" },
  e = { "<cmd>BufferCloseAllButCurrent<CR>", "Close all, but current buffer" },
  r = { "<cmd>BufferCloseAllButPinned<CR>", "Close all, but pinned buffers" },
  j = { "<cmd>BufferPick<CR>", "Jump to buffer" },
  c = { "<cmd>BufferClose<CR>", "Close buffer" },
  D = { "<cmd>BufferOrderByDirectory<CR>", "Order by directory" },
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = [[<C-T>]]
lvim.builtin.nvimtree.active = false
lvim.builtin.project.manual_mode = true
lvim.builtin.nvimtree.setup.disable_netrw = false

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "elixir",
  "heex",
  "javascript",
  "json",
  "lua",
  "python",
  "css",
  "rust",
  "yaml",
}

-- Additional Plugins
lvim.plugins = {
  { "joshdick/onedark.vim" },
}
