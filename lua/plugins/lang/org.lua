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
            
            -- Set up highlight groups for orgmode agenda using no-clown-fiesta colors
            local colors = {
                none = "NONE",
                fg = "#E1E1E1",
                bg = "#151515",
                alt_bg = "#171717",
                accent = "#202020",
                white = "#E1E1E1",
                gray = "#373737",
                medium_gray = "#727272",
                light_gray = "#AFAFAF",
                blue = "#BAD7FF",
                gray_blue = "#7E97AB",
                medium_gray_blue = "#A2B5C1",
                cyan = "#88afa2",
                red = "#b46958",
                green = "#90A959",
                yellow = "#F4BF75",
                orange = "#FFA557",
                purple = "#AA749F",
                magenta = "#AA759F",
                cursor_fg = "#151515",
                cursor_bg = "#D0D0D0",
                sign_add = "#586935",
                sign_change = "#51657B",
                sign_delete = "#984936",
                error = "#984936",
                warning = "#ab8550",
                info = "#ab8550",
                hint = "#576f82",
                todo = "#578266",
                accent_lighter_blue = "#1e222a",
                accent_blue = "#18191b",
                accent_green = "#181b18",
                accent_red = "#1b1818",
            }
            
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "*",
                callback = function()
                    -- Agenda highlights
                    vim.api.nvim_set_hl(0, "@org.agenda.date", { fg = colors.gray_blue, bg = colors.none })
                    vim.api.nvim_set_hl(0, "@org.agenda.date.today", { fg = colors.green, bg = colors.none, bold = true })
                    vim.api.nvim_set_hl(0, "@org.agenda.date.weekend", { fg = colors.red, bg = colors.none })
                    vim.api.nvim_set_hl(0, "@org.agenda.time_grid", { fg = colors.medium_gray, bg = colors.none })
                    vim.api.nvim_set_hl(0, "@org.agenda.clocking", { fg = colors.orange, bg = colors.none })
                    vim.api.nvim_set_hl(0, "@org.agenda.scheduled", { fg = colors.yellow, bg = colors.none })
                    vim.api.nvim_set_hl(0, "@org.agenda.scheduled_past", { fg = colors.red, bg = colors.none })
                    vim.api.nvim_set_hl(0, "@org.agenda.deadline", { fg = colors.red, bg = colors.none })
                    vim.api.nvim_set_hl(0, "@org.agenda.deadline_warning", { fg = colors.warning, bg = colors.none })
                    vim.api.nvim_set_hl(0, "@org.agenda.done", { fg = colors.green, bg = colors.none, strikethrough = true })
                    vim.api.nvim_set_hl(0, "@org.agenda.todo", { fg = colors.yellow, bg = colors.none })
                    vim.api.nvim_set_hl(0, "@org.agenda.priority", { fg = colors.purple, bg = colors.none })
                    vim.api.nvim_set_hl(0, "@org.agenda.tags", { fg = colors.medium_gray, bg = colors.none })
                    vim.api.nvim_set_hl(0, "@org.agenda.headline", { fg = colors.fg, bg = colors.none })
                end,
            })
            
            -- Trigger the highlight setup
            vim.cmd("doautocmd ColorScheme")
            
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

                org_todo_keyword_faces = {
                    TODO = ":foreground #b46958 :weight bold",
                    PROGRESS = ":foreground #FFA557 :weight bold",
                    WAITING = ":foreground #AA749F :weight bold",
                    REVIEW = ":foreground #576F82 :weight bold",
                    DONE = ":foreground #90A959 :weight bold",
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
                    org = {
                        -- org_todo_cycle = "cit",
                        -- org_todo_cycle_backward = "ciT",
                    }
                },
            })
        end,
    },
}