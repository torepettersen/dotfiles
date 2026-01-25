local wk = require "which-key"
local functions = require "functions"
local tabufline = require "nvchad.tabufline"

local map = vim.keymap.set

wk.add({
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>t", group = "Test" },
  { "<leader>b", group = "Buffer" },
})

-- General mappings
map("n", "<leader>q", "<cmd>:quit<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>:quitall<cr>", { desc = "Quit all" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })

-- Window jumping
map("n", "<C-h>", "<C-w>h", { desc = "Switch Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch Window up" })

-- Neotree mappings
map("n", "<leader>e", "<cmd>Neotree float %:./ %:p<cr>", { desc = "Open explorer" })
map("n", "<leader>bf", "<cmd>Neotree float buffers<cr>", { desc = "Buffer explorer" })

-- Toggleterm mappings
map({ "n", "t" }, "<C-t>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
map("n", "<leader>gl", functions.lazygit, { desc = "Lazygit" })

-- Telescope mappings
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

-- Buffers
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Buffer new" })
map("n", "<tab>", tabufline.next, { desc = "Buffer Goto next" })
map("n", "<S-tab>", tabufline.prev, { desc = "Buffer Goto prev" })
map("n", "<leader>x", tabufline.close_buffer, { desc = "Buffer close" })

-- Projectionist mappings
map("n", "<leader>a", "<cmd>A<cr>", { desc = "Alternate file" })

-- Neotest mappings
map("n", "<leader>tr", functions.tests.run, { desc = "Run nearest" })
map("n", "<leader>tf", functions.tests.run_file, { desc = "Run file" })
map("n", "<leader>ts", functions.tests.toggle_summary, { desc = "Toggle summary" })
map("n", "<leader>to", functions.tests.show_output, { desc = "Show output" })
map("n", "<leader>th", functions.tests.stop, { desc = "Stop" })

-- Sessions
map("n", "<leader>s", [[<cmd>lua require("persistence").load()<cr>]], { desc = "Resume session" })
