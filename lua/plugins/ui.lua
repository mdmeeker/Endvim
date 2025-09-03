return {
    -- Colorscheme
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function() 
            vim.g.everforest_background = "hard"
            vim.g.everforest_better_performance = 1
            vim.cmd("colorscheme everforest")
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim", 
        dependencies = { "nvim-lua/plenary.nvim" }, 
        cmd = "Telescope", 
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
        }
    },

    -- WhichKey
    { 
        "folke/which-key.nvim", 
        config = function()
            require("which-key").setup({
                plugins = {
                    spelling = true
                },
                win = {
                    border = "rounded",
                },
            })
        end,
    },
}