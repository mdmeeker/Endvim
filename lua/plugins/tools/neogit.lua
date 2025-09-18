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
        },
        config = function()
            local actions = require("diffview.actions")

            require("diffview").setup({
                diff_binaries = false,
                enhanced_diff_gl = true,
                git_cmd = { "git" },
                use_icons = true,
                icons = {
                    folder_closed = "",
                    folder_open = "",
                },
                signs = {
                    fold_closed = "",
                    fold_open = "",
                },
                file_panel = {
                    listing_style = "tree",
                    tree_options = {
                        flatten_directories = true,
                        folder_statuses = "only_folded",
                    },
                    win_config = {
                        position = "left",
                        width = 35,
                    },
                },
                file_history_panel = {
                    log_options = {
                        single_file = {
                            diff_merges = "combined",
                        },
                        multile_file = {
                            diff_merges = "first-parent",
                        },
                    },
                    win_config = {
                        position = "bottom",
                        height = 16,
                    },
                },
                commit_log_panel = {
                    win_config = {},
                },
                default_args = {
                    DiffviewOpen = {},
                    DiffviewFileHistory = {},
                },
                keymaps = {
                    views = {
                        gf = actions.goto_file_edit,
                        ["-"] = actions.toggle_stage_entry,
                    },
                    file_panel = {
                        ["<cr>"] = actions.focus_entry,
                        s = actions.toggle_stage_entry,
                        gf = actions.goto_file_edit,
                        ["?"] = "<Cmd>h diffview-maps-file-panel<CR>",
                    },
                    file_history_panel = {
                        ["<cr>"] = actions.focus_entry,
                        gf = actions.goto_file_edit,
                        ["?"] = "<Cmd>h diffview-maps-file-history-panel<CR>"
                    }
                }
            })
        end
    }
}