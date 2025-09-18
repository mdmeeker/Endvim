return {
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        dependencies = { 
            "nvim-lua/plenary.nvim", 
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("neogit").setup({
                disable_signs = false,
                disable_hint = true,
                disable_context_highlighting = false,
                disable_builtin_notifications = true,
                status = {
                    recent_commit_count = 20,
                },
                signs = {
                    section = { "", "" },
                    item = { "", "" },
                    hunk = { "", "" },
                },
                integrations = {
                    diffview = true,
                    telescope = true,
                },
                sections = {
                    recent = {
                        folded = false,
                    },
                },
                mappings = {
                    status = {
                        B = "BranchPopup",
                    },
                },
            })

            local neogit_group = vim.api.nvim_create_augroup("NeogitGroup", { clear = true })

            vim.api.nvim_create_autocmd("FileType", {
                group = neogit_group,
                pattern = "Neogit*",
                callback = function()
                    vim.opt_local.list = false
                end,
            })

            vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
                group = neogit_group,
                pattern = "NeogitCommitView",
                callback = function()
                    local current_eventignore = vim.opt.eventignore:get()
                    table.insert(current_eventignore, "CursorMoved")
                    vim.opt.eventignore = current_eventignore
                end,
            })

            vim.api.nvim_create_autocmd("BufLeave", {
                group = neogit_group,
                pattern = "NeogitCommitView",
                callback = function()
                    local current_eventignore = vim.opt.eventignore:get()
                    for i, v in ipairs(current_eventignore) do
                        if v == "CursorMoved" then
                            table.remove(current_eventignore, i)
                            break
                        end
                    end
                    vim.opt.eventignore = current_eventignore
                end,
            })
        end
    },
    {
        "pwntester/octo.nvim",
        cmd = "Octo",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("octo").setup()
        end
    },

    {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewFileHistory",
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewRefresh",
            "DiffviewLog",
        }
    }
}