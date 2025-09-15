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
            org_capture_templates = {
              {
                description = "Todo",
                template = "* TODO %?\n  %u",
                keys = "t",
                target = "~/org/notes.org",
              },
              {
                description = "Note",
                template = "* %?\n  %u :NOTE:",
                keys = "n",
                target = "~/org/notes.org",
              },
            },
            mappings = {
            --   global = {
            --     org_agenda = "<leader>oa",
            --     org_capture = "<leader>oc",
            --   },
            },
          })
          require("org-bullets").setup()
          require("headlines").setup(
            {
                org = {
                    headline_highlights = { "Headline1", "Headline2", "Headline3" },
                    bullet_highlights = { "OrgBullet" },
                    bullets = { "◉", "○", "✸", "✿" }, -- Custom bullets for visual hierarchy
                    fat_headlines = false, -- Slimmer headlines for cleaner look
                },
            }
          )
        end,
      },
}