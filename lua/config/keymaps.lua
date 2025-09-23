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

-- Org keymaps
vim.keymap.set("n", "<leader>oa", "<cmd>OrgAgenda<CR>", { desc = "Open org agenda" })
vim.keymap.set("n", "<leader>oc", "<cmd>OrgCapture<CR>", { desc = "Open org capture" })
vim.keymap.set("n", "<leader>or", "<cmd>vsplit ~/notes/refile.org<CR>", { desc = "Open refile.org" })
vim.keymap.set("n", "<leader>ot", "<cmd>vsplit ~/notes/todo.org<CR>", { desc = "Open todo.org" })
vim.keymap.set("n", "<leader>od", "<cmd>vsplit ~/notes<CR>", { desc = "Open notes directory" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "org" },
    callback = function()
        -- Date/time insertion
        vim.keymap.set("n", "<leader>oD", "<cmd>OrgDate<CR>", { desc = "Insert date", buffer = true })
        vim.keymap.set("n", "<leader>oT", "<cmd>OrgTime<CR>", { desc = "Insert time", buffer = true })

        -- Scheduling and deadlines
        vim.keymap.set("n", "<leader>os", "<cmd>OrgSchedule<CR>", { desc = "Schedule task", buffer = true })
        vim.keymap.set("n", "<leader>oE", "<cmd>OrgDeadline<CR>", { desc = "Set deadline", buffer = true })

        -- Priority and tags
        vim.keymap.set("n", "<leader>op", "<cmd>OrgPriority<CR>", { desc = "Set priority", buffer = true })
        vim.keymap.set("n", "<leader>og", "<cmd>OrgTags<CR>", { desc = "Set tags", buffer = true })

        -- Navigation
        vim.keymap.set("n", "<leader>on", "<cmd>OrgNext<CR>", { desc = "Next heading", buffer = true })
        vim.keymap.set("n", "<leader>oN", "<cmd>OrgPrev<CR>", { desc = "Previous heading", buffer = true })

        -- Promotes/Demotes'
        vim.keymap.set("n", "<leader>o>", "<cmd>OrgPromote<CR>", { desc = "Promote heading", buffer = true })
        vim.keymap.set("n", "<leader>o<", "<cmd>OrgDemote<CR>", { desc = "Demote heading", buffer = true })
    end,
})


-- File explorers
vim.keymap.set("n", "<leader>e", 
    function()
        local MiniFiles = require("mini.files")
        if MiniFiles.close() then
            return
        end
        MiniFiles.open(nil, { window = { win_blend = 0 } })
    end, 
    { desc = "Toggle floating file explorer"}
)
vim.keymap.set("n", "<leader>ft", ":NvimTreeToggle<CR>", { desc = "Toggle nvim-tree sidebar" })
vim.keymap.set("n", "<leader>fT", ":NvimTreeFocus<CR>", { desc = "Focus nvim-tree sidebar" })

vim.keymap.set("n", "<leader>gs", function()
    require("mini.git").show()
end, { desc = "Show git status" })

vim.keymap.set("n", "<leader>gd", function()
    require("mini.git").diff()
end, { desc = "Show git diff" })

vim.keymap.set("n", "<leader>gb", function()
    require("mini.git").blame()
end, { desc = "Show git blame" })

vim.keymap.set("n", "<leader>bd", ":lua MiniTabline.close_buffer()<CR>", { desc = "Close buffer" })

-- Neogit
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Show neogit" })
vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<CR>", { desc = "Commit" })
vim.keymap.set("n", "<leader>gp", "<cmd>Neogit pull<CR>", { desc = "Pull" })
vim.keymap.set("n", "<leader>gP", "<cmd>Neogit push<CR>", { desc = "Push" })


-- Zen mode and Twilight toggles
vim.keymap.set("n", "<leader>z", function()
    require("zen-mode").toggle()
end, { desc = "Toggle zen mode" })

-- Terminal keymaps
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<leader>tb", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal split" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle vertical split" })
