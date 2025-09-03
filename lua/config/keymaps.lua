-- This module is just used to configure vim keymaps; some package keymaps
-- are configured in their respective modules/the lazy.nvim config
--------------------------------------------------------------------------

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- LaTeX keymaps (vimtex)
vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>", { desc = "Compile LaTeX" })
vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "View PDF" })
vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<cmd>", { desc = "Stop vimtex" })
vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", { desc = "Show errors" })
vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocOpen<CR>", { desc = "Table of contents" })


-- Mini keymaps
vim.keymap.set("n", "<leader>e", 
    function()
        local MiniFiles = require("mini.files")
        if MiniFiles.close() then
            return
        end
        MiniFiles.open()
    end, 
    { desc = "Toggle file explorer"}
)
vim.keymap.set("n", "<leader>gs", function()
    require("mini.git").show()
end, { desc = "Show git status" })

vim.keymap.set("n", "<leader>gd", function()
    require("mini.git").diff()
end, { desc = "Show git diff" })

vim.keymap.set("n", "<leader>gb", function()
    require("mini.git").blame()
end, { desc = "Show git blame" })


-- Zen mode and Twilight toggles
vim.keymap.set("n", "<leader>z", function()
    require("zen-mode").toggle()
end, { desc = "Toggle zen mode" })

