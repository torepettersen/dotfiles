-- general
vim.opt.relativenumber = true

lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "lunar"

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

-- Projectionist
vim.api.nvim_set_var('projectionist_heuristics', {
  ['mix.exs|lib/*.ex'] = {
    ['lib/**/live/*_live.ex'] = {
      alternate = 'lib/{dirname}/live/{basename}_live.html.heex',
      type = 'source',
      template = {
        "defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Live do",
        "  use {dirname|camelcase|capitalize}, :live_view",
        "",
        "  def mount(_params, _session, socket) do",
        "    {open}:ok, socket{close}",
        "  end",
        "end"
      },
    },
    ['lib/**/live/*_live.html.heex'] = {
      alternate = 'lib/{dirname}/live/{basename}_live.ex',
      type = 'template',
    },
    ['lib/*.ex'] = {
      alternate = 'test/{}_test.exs',
      type = 'source',
      template = {
        "defmodule {camelcase|capitalize|dot} do",
        "end"
      },
    },
    ['test/*_test.exs'] = {
      alternate = 'lib/{}.ex',
      type = 'source',
      template = {
        "defmodule {camelcase|capitalize|dot}Test do",
        "  use ExUnit.Case, async: true",
        "",
        "  alias {camelcase|capitalize|dot}",
        "end"
      },
    },
  },
})

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
lvim.builtin.which_key.mappings["a"] = { "<cmd>A<cr>", "Jump to test" }
lvim.builtin.which_key.mappings["e"] = { "<cmd>Explore<cr>", "Explore" }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = [[<C-t>]]
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
  { "tpope/vim-projectionist" },
}
