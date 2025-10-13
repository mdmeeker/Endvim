return {
    {
        "vague2k/vague.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local opts = {
                transparent = true,
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
}