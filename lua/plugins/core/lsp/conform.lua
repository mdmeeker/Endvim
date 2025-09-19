return {
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                format_on_save = {
                    timeout_ms = 1000,
                    lsp_fallback = true,
                },
                formatters_by_ft = {
                    lua = { "stylua" },
                    markdown = { "prettierd", "prettier" },
                    c = { "clang_format" },
                    cpp = { "clang_format" },
                    python = { "ruff_format", "black" },
                    sh = { "shfmt" },
                    rust = { "rustfmt" },
                    julia = { "juliafmt" },
                },
                formatters = {
                    prettier = {
                        prepend_args = { "--prose-wrap", "always" },
                    },
                },
            })
        end,
    },
}