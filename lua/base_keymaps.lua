local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

keymap("", "<Space>", "<Nop>", {})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------
-- Normal Mode --
-----------------
keymap ("n", "<C-h>", "<C-w>h", {})
keymap ("n", "<C-j>", "<C-w>j", {})
keymap ("n", "<C-k>", "<C-w>k", {})
keymap ("n", "<C-l>", "<C-w>l", {})

keymap ("n", "<M-h>", ":vertical resize -5<cr>", {})
keymap ("n", "<M-j>", ":resize +5<cr>", {})
keymap ("n", "<M-k>", ":resize -5<cr>", {})
keymap ("n", "<M-l>", ":vertical resize +5<cr>", {})

keymap ("n", "<TAB>", ":bnext<CR>", {})
keymap ("n", "<S-TAB>", ":bprevious<CR>", {})

keymap ("n", "<", "<<", {})
keymap ("n", ">", ">>", {})

keymap ("n", "Q", "q", {})
keymap ("n", "q", "<nop>", {})

-----------------
-- Insert Mode --
-----------------
keymap ("i", "<Esc>", "<Esc>`^", {})

vim.cmd([[
  nnoremap n nzzzv
  nnoremap N Nzzzv
]])

-----------------
-- Visual Mode --
-----------------
vim.cmd([[
  nnoremap <C-A-J> :m .+1<CR>==
  nnoremap <C-A-K> :m .-2<CR>==
  inoremap <C-A-J> <Esc>:m .+1<CR>==gi
  inoremap <C-A-K> <Esc>:m .-2<CR>==gi
  vnoremap <C-A-J> :m '>+1<CR>gv=gv
  vnoremap <C-A-K> :m '<-2<CR>gv=gv
]])
