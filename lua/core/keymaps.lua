-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }


-----------------
-- Normal mode --
-----------------

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
keymap.set("n", "<A-h>", ":vertical resize -5<cr>", opts)
keymap.set("n", "<A-l>", ":vertical resize +5<cr>", opts)
keymap.set("n", "<A-k>", ":resize -5<cr>", opts)
keymap.set("n", "<A-j>", ":resize +5<cr>", opts)

-- Indentation
keymap.set("n", ">", ">>", opts)
keymap.set("n", "<", "<<", opts)

-- NvimTree
keymap.set("n", "<A-2>", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Terminal navigation
keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Terminal toggle
keymap.set("n", "<A-1>", ":ToggleTerm direction=float<CR>", opts)
keymap.set("t", "<A-1>", "<C-\\><C-n>:ToggleTerm<CR>", opts)

-- Force attach Ruff LSP for debugging
keymap.set("n", "<leader>lr", function() _G.force_attach_ruff() end, { desc = "Force attach Ruff LSP" })

-- Add any other keymaps you want here
