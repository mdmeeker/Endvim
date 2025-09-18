return {
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        config = function()
            require("trouble").setup({
                mode = "document_diagnostics",
                auto_close = true,
                signs = { error = "●", warning = "●", hint = "●", information = "●" },
            })
        end,
    },
}