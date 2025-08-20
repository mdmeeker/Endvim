return {
    {
        "lervag/vimtex",
        ft = "tex",
        opts = {
            tex_flavor = "latex",
            view_method = "general",
            quickfix_mode = 0,
            compiler_method = "latexmk",
            compiler_latexmk = { options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" } },
        },
        init = function()
            vim.g.vimtex_mappings_prefix = "<leader>l"
            vim.g.vimtex_view_general_viewer = "/Applications/Preview.app/Contents/MacOS/Preview"
            vim.g.vimtex_view_general_options = "-r @line @pdf @tex"
        end,
    },
    {
        "chomosuke/typst-preview.nvim",
        ft = "typ",
        build = ":TypstPreviewUpdate",
        opts = { viewer = "preview", dependencies_bin = { typst = "typst" }, get_root = function() return vim.fn.getcwd() end },
        keys = { { "<leader>lp", "<cmd>TypstPreview<CR>", desc = "Typst Preview" }, { "<leader>lc", "<cmd>TypstPreviewStop<CR>", desc = "Stop Typst Preview" } },
    },
    { "JuliaEditorSupport/julia-vim", ft = "julia" },
    {
        "jpalardy/vim-slime",
        ft = { "python", "julia" },
        config = function()
            vim.g.slime_target = "neovim"
            vim.g.slime_python_ipython = 1
        end,
        keys = { { "<leader>sr", "<Plug>SlimeRegionSend", mode = "x", desc = "Send to REPL" } },
    },
}