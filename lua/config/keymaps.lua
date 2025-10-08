-- This module is just used to configure vim keymaps; some package keymaps
-- are configured in their respective modules/the lazy.nvim config
--------------------------------------------------------------------------

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window resizing
vim.keymap.set("n", "<A-h>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<A-l>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<A-j>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<A-k>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })

-- LaTeX keymaps (vimtex)
vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>", { desc = "Compile LaTeX" })
vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "View PDF" })
vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<cmd>", { desc = "Stop vimtex" })
vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", { desc = "Show errors" })
vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocOpen<CR>", { desc = "Table of contents" })
vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<CR>", { desc = "Clean aux files" })
vim.keymap.set("n", "<leader>lm", "<cmd>VimtexMain<CR>", { desc = "Open main file" })
vim.keymap.set("n", "<leader>lr", "<cmd>VimtexReload<CR>", { desc = "Reload vimtex" })
vim.keymap.set("n", "<leader>lR", "<cmd>VimtexReloadState<CR>", { desc = "Reload vimtex state" })
vim.keymap.set("n", "<leader>li", "<cmd>VimtexInfo<CR>", { desc = "Show vimtex info" })
vim.keymap.set("n", "<leader>lI", "<cmd>VimtexInfoFull<CR>", { desc = "Show full vimtex info" })

-- Org keymaps
vim.keymap.set("n", "<leader>or", "<cmd>vsplit ~/notes/refile.org<CR>", { desc = "Open refile.org" })
vim.keymap.set("n", "<leader>ot", "<cmd>vsplit ~/notes/todo.org<CR>", { desc = "Open todo.org" })
vim.keymap.set("n", "<leader>od", "<cmd>vsplit ~/notes<CR>", { desc = "Open notes directory" })

-- File explorers
vim.keymap.set("n", "<leader>ft", ":NvimTreeToggle<CR>", { desc = "Toggle nvim-tree sidebar" })
vim.keymap.set("n", "<leader>fT", ":NvimTreeFocus<CR>", { desc = "Focus nvim-tree sidebar" })

-- Zen mode
vim.keymap.set("n", "<leader>z", function()
    require("zen-mode").toggle()
end, { desc = "Toggle zen mode" })

-- Terminal keymaps
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<leader>tb", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal split" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle vertical split" })
