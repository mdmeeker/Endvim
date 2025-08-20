-- This module is just used to configure vim options and global variables
-------------------------------------------------------------------------

-- Set leader to space
vim.g.mapleader = " "

-- Display options
vim.opt.number = true                    -- Show line numbers
vim.opt.relativenumber = true           -- Show relative line numbers
vim.opt.signcolumn = "yes"              -- Always show the sign column (for git, lsp, etc.)
vim.opt.scrolloff = 8                   -- Keep 8 lines above/below cursor when scrolling

-- Colors and appearance
vim.opt.termguicolors = true            -- Enable true color support
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"  -- Custom cursor shapes for different modes

-- File handling
vim.opt.undofile = true                 -- Persist undo history across sessions
vim.opt.swapfile = false                -- Disable swap files (use undofile instead)
vim.opt.clipboard = "unnamedplus"       -- Use system clipboard for yank/put operations

-- Performance and responsiveness
vim.opt.timeoutlen = 300                -- Time to wait for key sequence completion (ms)
vim.opt.updatetime = 100                -- Time to write swap file and trigger CursorHold (ms)

-- Code folding
vim.opt.foldmethod = "expr"             -- Use expression-based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"  -- Use TreeSitter for folding
vim.opt.foldenable = false              -- Start with all folds open
