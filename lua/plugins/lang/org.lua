return {
    {
        "nvim-orgmode/orgmode",
        ft = { "org" },
        config = function()
            local ok_ts = pcall(require, "nvim-treesitter.configs")
            if ok_ts then require("orgmode").setup_ts_grammar() end

            require("orgmode").setup({
                org_agenda_files = { "~/org/**/*", "~/notes/**/*.org" },
                org_default_notes_file = "~/org/refile.org",

                org_todo_keywords = { "TODO(t)", "NEXT(n)", "|", "DONE(d)", "CANCELLED(c)" },
                org_capture_templates = {
                    t = {
                        description = "Todo",
                        target = "~/org/todo.org",
                        template = "* TODO %?\n  %u",
                    },
                    n = {
                        description = "Note",
                        target = "~/org/refile.org",
                        template = "* %?\n  %u",
                    },
                },
            })
        end,
    },
}