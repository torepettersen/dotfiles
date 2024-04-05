local options = {
  filesystem = {
    filtered_items = {
      visible = true,
    },
  },
  window = {
    mappings = {
      ["<Tab>"] = "next_source",
      ["<S-Tab>"] = "prev_source",
    },
    fuzzy_finder_mappings = {
      ["<C-j>"] = "move_cursor_down",
      ["<C-k>"] = "move_cursor_up",
    },
  },
  buffers = {
    window = {
      mappings = {
        ["c"] = "buffer_delete",
      },
    },
  },
}

require("neo-tree").setup(options)
