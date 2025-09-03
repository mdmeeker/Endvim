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


    -- Zen mode and twilight
    -- Zen mode
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({
                window = {
                    backdrop = 0.95, -- Dim the background
                    width = 0.95,     -- Width of the zen window
                    height = 0.95,    -- Height of the zen window
                    options = {
                        number = false,
                        relativenumber = false,
                        foldcolumn = "0",
                        list = false,
                        showbreak = "",
                        signcolumn = "no",
                        wrap = true,
                        linebreak = true,
                    },
                },
                plugins = {
                    options = {
                        enabled = true,
                        ruler = false,
                        showcmd = false,
                        laststatus = 0,
                    },
                    twilight = { enabled = false },
                    gitsigns = { enabled = false },
                    tmux = { enabled = false },
                    kitty = { enabled = false },
                    alacritty = { enabled = false },
                    wezterm = { enabled = false },
                    iterm = { enabled = false },
                },
            })
        end,
    },
}