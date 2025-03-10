-- Core Neovim options
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation (default settings, will be overridden by ftplugin)
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Enable mouse support
opt.mouse = 'a'
