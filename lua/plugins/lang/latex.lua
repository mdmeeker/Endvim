return {
    {
        "lervag/vimtex",
        ft = { "tex", "bib" },
        init = function()
            -- vimtex globals must be set BEFORE the plugin loads
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
                    "-recorder",
                },
            }
            vim.g.vimtex_view_method = "skim"
            vim.g.vimtex_complete_enabled = 0

            -- Use vimtex’s regex syntax, not Tree-sitter
            vim.g.vimtex_syntax_treesitter = 0
            vim.g.vimtex_syntax_enabled = 1

            -- Other vimtex toggles
            vim.g.vimtex_indent_enabled = 0
            vim.g.vimtex_fold_enabled = 0
            vim.g.vimtex_imaps_enabled = 0
            vim.g.vimtex_text_obj_enabled = 0

            -- Project detection
            vim.g.vimtex_main_file_search_method = "project"
            vim.g.vimtex_main_file_search_depth = 3
            vim.g.vimtex_main_file_search_patterns = {
                "main.tex",
                "document.tex",
                "thesis.tex",
                "paper.tex",
                "%.tex$",
            }

            -- Ensure syntax is enabled when opening LaTeX buffers
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "tex", "latex" },
                callback = function()
                    if vim.fn.exists("syntax_on") == 0 then
                        vim.cmd("syntax enable")
                    end
                end,
            })
        end,
        config = function()
            -- Window-local tweaks (set after buffer exists)
            vim.wo.conceallevel = 2
            vim.wo.concealcursor = "c"
        end,
    },
}