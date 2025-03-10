-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Setup and configure nvim-tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
  },
})

-- Debug keymap to test F2 recognition
vim.keymap.set("n", "<F2>", function()
    print("F2 key pressed")
end, { desc = "Test F2 key" })

-- Keymaps using the nvim-tree API
local api = require("nvim-tree.api")
vim.keymap.set("n", "<F2>", api.tree.toggle, { desc = "Toggle file explorer" })