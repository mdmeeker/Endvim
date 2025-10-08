return {

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()

            vim.diagnostic.config({
                virtual_text = false,
                underline = { severity = { min = vim.diagnostic.severity.INFO } },
                signs = { severity = { min = vim.diagnostic.severity.HINT } },
                float = {
                    show_header = false,
                    source = true,
                },
                update_in_insert = false,
                severity_sort = true,
                signs = {
                    Error = { text = "󰅚", texthl = "DiagnosticSignError" },
                    Warn = { text = "󰀪", texthl = "DiagnosticSignWarn" },
                    Info = { text = "󰋽", texthl = "DiagnosticSignInfo" },
                    Hint = { text = "󰌶", texthl = "DiagnosticSignHint" },
                },
            })
        end,
    },

    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostics at line" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostics" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostics" })

            local null_ls = require("null-ls")
            local sources = {}

            -- Diagnostics
            table.insert(sources, null_ls.builtins.diagnostics.selene) -- Lua
            table.insert(sources, null_ls.builtins.diagnostics.cppcheck) -- C/C++
            table.insert(sources, null_ls.builtins.diagnostics.markdownlint) -- Markdown

            -- Code actions
            table.insert(sources, null_ls.builtins.code_actions.gitsigns)
            table.insert(sources, null_ls.builtins.code_actions.refactoring)

            null_ls.setup({
                sources = sources,
                diagnostics_format = "[#{c}] #{m} (#{s})",
                debug = false,
                debounce = 250,
                timeout = 5000,
            })
        end,
        event = { "BufReadPre", "BufNewFile" },
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        config = function()
            require("trouble").setup({
                mode = "document_diagnostics",
                auto_close = true,
                signs = { error = "●", warning = "●", hint = "●", information = "●" },
            })
        end,
    },
}