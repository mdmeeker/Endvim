return {
    {
        "lervag/vimtex",
        ft = { "tex", "bib", "*.tex", "*.bib" },
        init = function()
            vim.g.vimtex_mappings_prefix = "<leader>l"
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = { options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" } }
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_complete_enabled = 0
        end,
    },
}