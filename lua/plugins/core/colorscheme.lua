return {
    {
        "aktersnurra/no-clown-fiesta.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local opts = {
                transparent = true,
                styles = {
                    type = { bold = true },
                    lsp = { underline = true },
                    match_paren = { underline = true },
                },
            }
            require("no-clown-fiesta").setup(opts)
            vim.cmd("colorscheme no-clown-fiesta")
        end
    },
    -- Colorscheme
    -- {
    --     "sainnhe/everforest",
    --     lazy = false,
    --     priority = 1000,
    --     config = function() 
    --         vim.g.everforest_background = "hard"
    --         vim.g.everforest_better_performance = 1
    --         vim.cmd("colorscheme everforest")
    --     end,
    -- },
    {
        "DaikyXendo/nvim-material-icon",
    }
}