-- <leader> keymap
vim.g.mapleader = " "
-- highlight current line
vim.cmd("set cursorline")
-- line number
vim.opt.number = true
vim.opt.relativenumber = true
-- indentation
-- tabsize 2, replace tab with spaces
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set expandtab")
vim.opt.breakindent = true

-- search ignores case by default
-- when search contains uppercase, it will be case sensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- undo history
vim.opt.undofile = true
-- sync clipboard with OS
vim.opt.clipboard = "unnamedplus"

-- highlight text when yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--vim.opt.incco
vim.opt.inccommand = "split"
vim.opt.hlsearch = true
vim.keymap.set("n", "<esc>", "<cmd>nohl<CR>", { desc = "Disable Search Highlight" })
