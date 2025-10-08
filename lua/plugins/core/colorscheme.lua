return {
    {
        "vague2k/vague.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local opts = {
                transparent = true, -- Keep your transparent background preference
                style = {
                    comments = "italic",
                    functions = "none",
                    keywords = "none",
                    lsp = "underline",
                    match_paren = "underline",
                    type = "bold",
                    variables = "none"
                },
            }
            require("vague").setup(opts)
            vim.cmd("colorscheme vague")
        end
    },
    -- {
    --     "aktersnurra/no-clown-fiesta.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         local opts = {
    --             transparent = true,
    --             styles = {
    --                 comments = {},
    --                 functions = {},
    --                 keywords = {},
    --                 lsp = { underline = true },
    --                 match_paren = { underline = true },
    --                 type = { bold = true },
    --                 variables = {}
    --             },
    --         }
    --         require("no-clown-fiesta").setup(opts)
    --         vim.cmd("colorscheme no-clown-fiesta")
    --     end
    -- },
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