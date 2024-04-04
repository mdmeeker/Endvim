local set = vim.opt

----------------------
-- GENERAL SETTINGS --
----------------------
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

-----------------
-- UI SETTINGS --
-----------------
set.pumheight = 15
set.ruler = true
set.splitbelow = true
set.splitright = true
set.conceallevel = 1
set.number = true
set.relativenumber = true
set.background = "dark"
set.ignorecase = true
set.smartcase = true
set.termguicolors = true
set.laststatus= 3
set.title = true
set.cursorline = true

-- Sets tabs to look/be 2 spaces, autocmd for Python whitespace adherence
set.shiftwidth = 2
set.tabstop = 2
vim.api.nvim_create_autocmd("FileType", {
	pattern = "py",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
	end
})

set.showtabline = 1
set.cmdheight = 1
set.numberwidth = 5
vim.cmd [[set noshowmode]]
vim.cmd [[syntax enable]]
vim.cmd [[set t_Co=256]]

--------------------------
-- PERFORMANCE SETTINGS --
--------------------------

set.hidden = true
set.timeoutlen = 500
set.lazyredraw = false
set.synmaxcol = 240
set.updatetime = 700


