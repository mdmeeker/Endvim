return {
    {
        "yorickpeterse/nvim-pqf",
        event = "VeryLazy",
        config = function()
            require("pqf").setup({
                signs = {
                    error = { text = '●', hl = 'DiagnosticSignError' },
                    warning = { text = '●', hl = 'DiagnosticSignWarn' },
                    info = { text = '●', hl = 'DiagnosticSignInfo' },
                    hint = { text = '●', hl = 'DiagnosticSignHint' }
                },
                show_multiple_lines = true,
                max_filename_length = 40,
            })
        end
    }
}
