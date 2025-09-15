return {
    {
        "folke/which-key.nvim",
        config = function()
            local wk = require("which-key")

            wk.setup({
                plugins = {
                    spelling = true,
                },
                win = {
                    border = "rounded",
                    height = { min = 5, max = 25 },
                },
            })

            wk.add({
                { "<leader>b", group = "Buffer" },
                { "<leader>l", group = "LaTeX/LSP" },
                { "<leader>t", group = "Terminal" },
                { "<leader>g", group = "Git" },
                { "<leader>z", group = "Zen Mode" },
                { "<leader>f", group = "File/Find" },
                { "<leader>o", group = "Org Mode" },
            })
        end,
    },
}