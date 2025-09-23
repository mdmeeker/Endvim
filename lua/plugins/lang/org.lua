return {
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = { "org" },
        dependencies = {
            "akinsho/org-bullets.nvim",
            "lukas-reineke/headlines.nvim",
            "hamidi-dev/org-super-agenda.nvim",
            "danilshvalov/org-modern.nvim",
        },
        config = function()
            require("org-bullets").setup()
            require("headlines").setup()
            -- Orgmode itself
            require("orgmode").setup({
                org_agenda_files = { "~/notes/**/*" },
                org_default_notes_file = "~/notes/refile.org",
                org_capture_templates = {
                    t = {
                        description = "To-do list",
                        template = "* TODO %?\n %u",
                        target = "~/notes/todo.org",
                    },
                    n = {
                        description = "Note",
                        template = "* %?\n %u",
                        target = "~/notes/refile.org"
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
            })

        end,
    },
}