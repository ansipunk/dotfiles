-- File tree

require("nvim-tree").setup({
  hijack_cursor = true,
  diagnostics = { enable = true },
  view = { side = "right" },
  filters = { custom = { "node_modules", ".cache" , "__pycache__" } },
  actions = { open_file = { quit_on_open = true, window_picker = { enable = true } } },
  renderer = {
    highlight_opened_files = "icon",
    add_trailing = true,
    group_empty = true,
    highlight_git = true,
    icons = { show = { file = true, folder = true, folder_arrow = true } },
    indent_markers = { enable = true }
  },
})
