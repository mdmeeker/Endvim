return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "cpp", "python", "julia", "latex", "typst", "org", "markdown", "markdown_inline" },
            highlight = { enable = true, additional_vim_regex_highlighting = { "org", "markdown", "markdown_inline" } },
            fold = { enable = true }
        },
    },
}