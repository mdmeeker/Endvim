return {
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_mappings_prefix = "<leader>l"
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = { options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" } }

            vim.g.vimtex_view_method = "general"
            vim.g.vimtex_view_general_viewer = "open"
            vim.g.vimtex_view_general_options = "-a Preview @pdf"
        end,
    },
    {
        "chomosuke/typst-preview.nvim",
        ft = "typ",
        build = ":TypstPreviewUpdate",
        opts = { viewer = "preview", dependencies_bin = { typst = "typst" }, get_root = function() return vim.fn.getcwd() end },
        keys = {
            { "<leader>lp", "<cmd>TypstPreview<CR>", desc = "Typst Preview" },
            { "<leader>lc", "<cmd>TypstPreviewStop<CR>", desc = "Stop Typst Preview" }
        },
    },
    -- { "JuliaEditorSupport/julia-vim", ft = "julia" },
    -- {
    --     "jpalardy/vim-slime",
    --     ft = { "python", "julia" },
    --     config = function()
    --         vim.g.slime_target = "neovim"
    --         vim.g.slime_python_ipython = 1
    --     end,
    --     keys = { { "<leader>sr", "<Plug>SlimeRegionSend", mode = "x", desc = "Send to REPL" } },
    -- },
}