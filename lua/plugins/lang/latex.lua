return {
    {
        "lervag/vimtex",
        ft = { "tex", "bib" },
        init = function()
            vim.g.vimtex_mappings_prefix = "<leader>l"
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = { 
                options = { 
                    "-aux-directory=build",
                    "-pdf",
                    "-interaction=nonstopmode",
                    "-synctex=1",
                    "-recorder"
                },
            }
            vim.g.vimtex_view_method = 'skim'
            vim.g.vimtex_complete_enabled = 0

            vim.wo.conceallevel = 2
            vim.wo.concealcursor = "c"

            -- Performance, etc
            vim.g.vimtex_syntax_treesitter = 0
            vim.g.vimtex_indent_enabled = 0
            vim.g.vimtex_fold_enabled = 0
            vim.g.vimtex_imaps_enabled = 0
            vim.g.vimtex_text_obj_enabled = 0
        end,
    },
}