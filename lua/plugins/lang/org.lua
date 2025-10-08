return {
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = { "org" },
        dependencies = {
            "akinsho/org-bullets.nvim",
            "lukas-reineke/headlines.nvim",
            "danilshvalov/org-modern.nvim",
        },
        config = function()
            require("org-bullets").setup()
            require("headlines").setup()
            
            -- Orgmode itself
            require("orgmode").setup({
                org_agenda_files = { vim.fn.expand("~/notes") .. "/*.org" },
                org_default_notes_file = vim.fn.expand("~/notes/refile.org"),

                org_todo_keywords = {
                    'TODO',
                    'PROGRESS',
                    'WAITING',
                    'REVIEW',
                    'DONE'
                },

                org_capture_templates = {
                    t = {
                        description = "To-do list",
                        template = "* TODO %?\n %u",
                        target = vim.fn.expand("~/notes/todo.org"),
                    },
                    n = {
                        description = "Note",
                        template = "* %?\n %u",
                        target = vim.fn.expand("~/notes/refile.org")
                    },
                },

                ui = {
                    menu = {
                        handler = function(data)
                            local Menu = require("org-modern.menu")
                            Menu:new():open(data)
                        end,
                    },
                },

                mappings = {
                    global = {
                        org_agenda = "<leader>oa",
                        org_capture = "<leader>oc",
                    },
                },
            })
        end,
    },
}