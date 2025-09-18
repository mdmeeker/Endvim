return {
    {
        "NeogitOrg/neogit",
        dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
        cmd = "Neogit",
        config = function()
            require("neogit").setup({
                integrations = { diffview = true },
                signs = {
                    section = { ">", "v" },
                    item = { ">", "v" },
                    hunk = { "", "" },
                }
            })
        end
    }
}