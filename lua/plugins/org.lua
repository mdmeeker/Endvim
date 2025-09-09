return {
    {
        "nvim-orgmode/orgmode",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "VeryLazy",
        ft = { "org" },
        config = function()
            require("orgmode").setup({
                org_agenda_files = { "~/org/**/*" },
                org_default_notes_file = "~/org/notes.org",
                org_todo_keywords = { "TODO", "IN_PROGRESS", "|", "DONE" },
                org_agenda_span = "week",
                org_hide_leading_stars = true,
                org_startup_folded = "overview",
                mappings = {

                },
            })
        end,
    }
}