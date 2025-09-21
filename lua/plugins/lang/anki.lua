return {
    "rareitems/anki.nvim",
    depdendencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("anki").setup({

        })
    end
}