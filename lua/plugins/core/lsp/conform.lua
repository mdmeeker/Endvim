return {
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                format_on_save = {
                    timeout_ms = 1000,
                    lsp_fallback = true,
                    filter = function(bufnr)
                        local filetype = vim.bo[bufnr].filetype
                        local disabled_filetypes = {
                            "markdown", "markdown_inline", "typst", "org", "norg", "norg_meta", "norg_table",
                            "git_rebase", "gitattributes", "gitcommit", "tex", "latex"
                        }
                        return not vim.tbl_contains(disabled_filetypes, filetype)
                    end
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