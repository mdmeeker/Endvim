----------------------
-- General settings --
----------------------
local set = vim.opt
set.swapfile = false
set.updatetime = 0
set.encoding="utf-8"
set.fileencoding="utf-8"
set.smartindent = true
set.iskeyword:append("-")
set.clipboard = "unnamedplus"
set.smarttab = true
set.expandtab = true
set.autoindent = true
set.autochdir = true
set.incsearch = true
set.shell = "/bin/zsh"
set.shortmess:append "sI"
set.inccommand = "nosplit"
set.hlsearch = true
vim.cmd [[set nobackup]]
vim.cmd [[set nowritebackup]]
vim.cmd [[set formatoptions-=cro]]
vim.cmd [[set complete+=kspell]]
vim.cmd [[set completeopt=menuone,longest]]
vim.cmd [[set nocompatible]]

---------------
-- Neovim UI --
---------------
set.pumheight = 15
set.ruler = true
set.splitbelow = true
set.splitright = true
set.conceallevel = 1
set.tabstop = 2
set.number = true
set.relativenumber = true
set.background = "dark"
set.ignorecase = true
set.smartcase = true
set.termguicolors = true
set.laststatus= 3
set.title = true
set.cursorline = true
set.shiftwidth = 2
set.showtabline = 1
set.cmdheight = 1
set.numberwidth = 5
vim.cmd [[set noshowmode]]
vim.cmd [[syntax enable]]
vim.cmd [[set t_Co=256]]

-----------------
-- Memory, CPU --
-----------------
set.hidden = true
set.timeoutlen = 500
set.lazyredraw = true
set.synmaxcol = 240
set.updatetime = 700
