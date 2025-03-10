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


-- Keymaps using the nvim-tree API
local api = require("nvim-tree.api")