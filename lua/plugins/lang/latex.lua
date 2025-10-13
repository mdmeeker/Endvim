return {
    {
        "lervag/vimtex",
        ft = { "tex", "plaintex", "latex" },
        init = function()
            vim.g.vimtex_mappings_prefix = "<leader>l"
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_complete_enabled = 0

            vim.wo.conceallevel = 2
            vim.wo.concealcursor = "c"

            vim.g.vimtex_view_method = "skim"           -- macOS: Skim.app

            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = {
                build_dir = "",
                callback = 1,
                continuous = 1,
                executable = "latexmk",
                options = {
                    "-pdf",
                    "-interaction=nonstopmode",
                    "-synctex=1",
                    "-file-line-error",
                    "-auxdir=build",        -- TeX Live latexmk
                    "-emulate-aux-dir",     -- keep final outputs in source dir
                },
            }
        end,
    },
}