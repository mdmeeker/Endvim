return {
    {
        "nvim-orgmode/orgmode",
        ft = "org",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("orgmode").setup_ts_grammar()
            require("orgmode").setup({
            org_agenda_files = "~/org/**/*",
            org_default_notes_file = "~/org/notes.org",
            mappings = {
                global = { org_agenda = "<leader>oa", org_capture = "<leader>oc" },
                org = { org_toggle_heading = "<leader>oh", org_toggle_checkbox = "<leader>ox" },
            },
            })
        end,
    },
}