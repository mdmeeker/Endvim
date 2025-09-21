return {
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { 
            "nvim-lua/plenary.nvim",
            "nvim-neorg/neorg-telescope",
        },
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                daily = "~/note/daily",
                                projects = "~/notes/projects",
                                meetings = "~/notes/meetings",
                                homework = "~/notes/homework",
                            },
                            default_workspace = "daily"
                        },
                    },
                    ["core.concealer"] = {},
                    ["core.completion"] = {
                        config = { engine = "nvim-cmp" },
                    },
                    ["core.export"] = {},
                    ["core.integrations.telescope"] = {},
                }
            })

        end
    }
}