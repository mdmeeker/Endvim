return {
    {
        "akinsho/toggleterm.nvim",
        keys = { 
            { "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle floating terminal" }, 
        },
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<C-\>]],
                shade_terminals = true,
                direction = "horizontal",
                float_opts = {
                    border = "curved",
                    width = math.floor(vim.o.columns * 0.7),
                    height = math.floor(vim.o.lines * 0.7),
                    windblend = 10,
                },
            })
        end
    }
}