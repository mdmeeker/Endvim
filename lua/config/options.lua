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
vim.opt.swapfile = true                 -- Enable swap files
vim.opt.directory = vim.fn.stdpath("state") .. "/swap" -- Centralized swap directory
vim.opt.backup = true                   -- Enable backup files
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"  -- Centralized backup directory
vim.opt.writebackup = true              -- Write backup before overwriting
vim.opt.clipboard = "unnamedplus"       -- Use system clipboard for yank/put operations

-- Performance and responsiveness
vim.opt.timeoutlen = 300                -- Time to wait for key sequence completion (ms)
vim.opt.updatetime = 100                -- Time to write swap file and trigger CursorHold (ms)
vim.opt.redrawtime = 3000               -- Time to wait to redraw screen (ms)
vim.opt.ttimeoutlen = 10               -- Time to wait for key codes (ms)

-- Logging and Debugging
vim.opt.verbose = 0 -- Default verbosity level
vim.opt.verbosefile = vim.fn.stdpath("state") .. "/nvim.log"

-- Code folding
vim.opt.foldmethod = "expr"             -- Use expression-based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"  -- Use TreeSitter for folding
vim.opt.foldenable = false              -- Start with all folds open

-- Tab and indentation
vim.opt.tabstop = 4         -- Number of spaces for a tab
vim.opt.shiftwidth = 4      -- Number of spaces for auto-indent
vim.opt.expandtab = true    -- Use spaces instead of tabs
vim.opt.softtabstop = 4     -- Number of spaces for a tab in insert mode

-- Splitting behavior
vim.opt.splitbelow = true  -- Split below instead of above
vim.opt.splitright = true  -- Split right instead of left

-- Create necessary directories
local function ensure_dir(path)
    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, "p")
    end
end

ensure_dir(vim.fn.stdpath("state") .. "/swap")
ensure_dir(vim.fn.stdpath("state") .. "/backup")
ensure_dir(vim.fn.stdpath("state") .. "/logs")
