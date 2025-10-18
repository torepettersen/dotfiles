local options = {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "󰍵" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "│" },
  },

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function opts(desc)
      return { buffer = bufnr, desc = desc }
    end

    local map = vim.keymap.set

    map("n", "<leader>gr", gs.reset_hunk, opts "Reset Hunk")
    map("n", "<leader>gR", gs.reset_buffer, opts "Reset Buffer")
    map("n", "<leader>gh", gs.preview_hunk, opts "Preview Hunk")
    map("n", "<leader>gb", gs.toggle_current_line_blame, opts "Blame Line")
  end,
}

return options
