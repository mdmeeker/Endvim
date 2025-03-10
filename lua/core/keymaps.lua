-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic keymaps
local keymap = vim.keymap

-- NvimTree
keymap.set("n", "<F2>", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer (alternative)" })

-- Add any other keymaps you want here
