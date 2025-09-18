return {
    {
        "folke/which-key.nvim",
        keys = { "<leader>", '"', "'", "`" },
        config = function()
            local wk = require("which-key")

            -- Copy nyoom's setup
            wk.setup({
                icons = {
                    breadcrumb = "»",
                    separator = "->",
                    group = "+",
                },
                win = {
                    border = "solid",
                    height = { min = 0, max = 6 },
                },
                layout = {
                    spacing = 3,
                },
                spec = {
                    mode = { "n", "v" },
                    -- Hide certain patterns (copying nyoom's hidden config)
                    ["<silent>"] = { mode = { "n", "v" } },
                    ["<cmd>"] = { mode = { "n", "v" } },
                    ["<Cmd>"] = { mode = { "n", "v" } },
                    ["<CR>"] = { mode = { "n", "v" } },
                    ["call"] = { mode = { "n", "v" } },
                    ["lua"] = { mode = { "n", "v" } },
                    ["^:"] = { mode = { "n", "v" } },
                    ["^ "] = { mode = { "n", "v" } },
                },
                triggers = {
                    -- Disable j/k in insert and visual mode (copying nyoom)
                    { "<auto>", mode = "nxso" },
                },
            })

            -- Register nyoom's group names exactly
            wk.add({
                { "<leader><tab>", group = "+workspace" },
                { "<leader>b", group = "+buffer" },
                { "<leader>c", group = "+code" },
                { "<leader>cl", group = "+LSP" },
                { "<leader>f", group = "+file" },
                { "<leader>g", group = "+git" },
                { "<leader>h", group = "+help" },
                { "<leader>hn", group = "+nyoom" },
                { "<leader>i", group = "+insert" },
                { "<leader>n", group = "+notes" },
                { "<leader>o", group = "+open" },
                { "<leader>oa", group = "+agenda" },
                { "<leader>p", group = "+project" },
                { "<leader>q", group = "+quit/session" },
                { "<leader>r", group = "+remote" },
                { "<leader>s", group = "+search" },
                { "<leader>t", group = "+toggle" },
                { "<leader>w", group = "+window" },
                { "<leader>m", group = "+localleader" },
                { "<leader>d", group = "+debug" },
                { "<leader>v", group = "+visual" },
            })
        end,
    },
}