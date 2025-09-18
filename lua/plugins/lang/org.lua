return {
    {
        "nvim-orgmode/orgmode",
        dependencies = { 
            "nvim-treesitter/nvim-treesitter", 
            "akinsho/org-bullets.nvim",
            "lukas-reineke/headlines.nvim"
        },
        event = "VeryLazy",
        ft = { "org" },
        config = function()
            require("orgmode").setup({
                org_agenda_files = { "~/org/agenda/*.org", "~/org/notes.org" },
                org_default_notes_file = "~/org/notes.org",
                org_todo_keywords = { "TODO", "NEXT", "IN_PROGRESS", "WAITING", "|", "DONE", "CANCELLED" },
                org_agenda_span = "week",
                org_agenda_start_on_weekday = 1,
                org_deadline_warning_days = 7,
                org_hide_leading_stars = true,
                org_startup_folded = "overview",
            
                -- Enhanced capture templates
                org_capture_templates = {
                    {
                        description = "Todo",
                        template = "* TODO %?\n  SCHEDULED: %T\n  %u",
                        keys = "t",
                        target = "~/org/notes.org",
                        headline = "Tasks", -- Optional: file under specific headline
                    },
                    {
                        description = "Note",
                        template = "* %?\n  %u :NOTE:",
                        keys = "n",
                        target = "~/org/notes.org",
                        headline = "Notes",
                    },
                    {
                        description = "Meeting",
                        template = "* MEETING %? :MEETING:\n  SCHEDULED: %T\n  ** Attendees\n  ** Agenda\n  ** Notes\n  ** Action Items",
                        keys = "m", 
                        target = "~/org/notes.org",
                        headline = "Meetings",
                    },
                    {
                        description = "Quick Note",
                        template = "* %?\n  %u",
                        keys = "q",
                        target = "~/org/inbox.org", -- Quick inbox for processing later
                    },
                },
            
                -- Add these useful settings
                org_archive_location = "~/org/archive.org::",
                org_log_done = "time", -- Log completion time
                org_log_into_drawer = "LOGBOOK", -- Keep logs organized
            
                -- Better agenda view
                org_agenda_templates = {
                    t = { description = "Today", template = "t", transformation = "agenda", properties = { span = "day" } },
                    w = { description = "This Week", template = "w", transformation = "agenda", properties = { span = "week" } },
                    m = { description = "This Month", template = "m", transformation = "agenda", properties = { span = "month" } },
                },
            })

            vim.keymap.set("n", "<leader>oo", "<cmd>Telescope find_files cwd=~/org<cr>", { desc = "Find Org Files" })
        
            require("org-bullets").setup({
                concealcursor = true, -- Hide markup when cursor is not on line
                symbols = {
                    headlines = { "◉", "○", "✸", "✿", "✤", "✜", "◆", "▶" },
                    checkboxes = {
                        half = { "", "OrgTSCheckboxHalfChecked" },
                        done = { "✓", "OrgDone" },
                        todo = { "˟", "OrgTODO" },
                    },
                },
            })
        
            require("headlines").setup({
                org = {
                    headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
                    bullet_highlights = { "OrgBullet" },
                    bullets = { "◉", "○", "✸", "✿" },
                    fat_headlines = false,
                    fat_headline_upper_string = "▃",
                    fat_headline_lower_string = "🬂",
                },
            })
        
            -- Set up keybindings (you can add these to your keymaps.lua instead)
            vim.keymap.set("n", "<leader>oa", "<cmd>lua require('orgmode').action('agenda.prompt')<CR>", { desc = "Org Agenda" })
            vim.keymap.set("n", "<leader>oc", "<cmd>lua require('orgmode').action('capture.prompt')<CR>", { desc = "Org Capture" })
        end,
    },

    -- Add table mode back as separate plugin for better org experience
    {
        "dhruvasagar/vim-table-mode",
        ft = "org",
        config = function()
            vim.g.table_mode_corner = "|" -- Org-style tables
            vim.g.table_mode_header_fillchar = "-"
            
            -- Auto-enable for org files
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "org",
                callback = function()
                    vim.cmd("TableModeEnable")
                end,
            })
        end,
        keys = {
            { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle Table Mode" },
        },
    },
}