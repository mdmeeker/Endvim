return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        config = function()
            require("mini.comment").setup()
        end,
    }
}