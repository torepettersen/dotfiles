return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "lexical",
        "elixir-ls",
        "nextls",
        "typescript-language-server",
        "svelte-language-server",
        "tailwindcss-language-server",
        "prettierd",
        "pyright",
        "black",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "html",
        "css",
        "elixir",
        "heex",
        "svelte",
        "javascript",
        "python",
        "hcl",
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Neotree" },
    config = function()
      require "configs.neo-tree"
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      direction = "float",
      float_opts = { border = "rounded" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-n>"] = require("telescope.actions").cycle_history_next,
            ["<C-p>"] = require("telescope.actions").cycle_history_prev,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
    },
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "jfpedroza/neotest-elixir",
    },
    config = function()
      require "configs.neotest"
    end,
  },

  {
    "tpope/vim-projectionist",
    event = "VeryLazy",
    config = function()
      require "configs.projectionist"
    end,
  },

  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").add_default_mappings()
    end,
    dependencies = {
      "tpope/vim-repeat",
    },
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "User FilePost",
    config = function()
      require("configs.colorizer").setup()
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    opts = function(plugin, opts)
      require("configs.cmp").options(plugin, opts)
    end,
  },

  { "NvChad/nvterm", enabled = false },
  { "nvim-tree/nvim-tree.lua", enabled = false },
}
