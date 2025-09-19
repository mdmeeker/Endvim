return {

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
        event = "LspAttach",
    },

    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            vim.diagnostic.config({
                underline = { severity = { min = vim.diagnostic.severity.INFO } },
                signs = { severity = { min = vim.diagnostic.severity.HINT } },
                virtual_text = false,
                float = {
                    show_header = false,
                    source = true,
                },
                update_in_insert = false,
                severity_sort = true,
            })

            local signs = {
                Error = "󰅚",  -- or your preferred error icon
                Warn = "󰀪",   -- or your preferred warn icon  
                Info = "󰋽",   -- or your preferred info icon
                Hint = "󰌶",   -- or your preferred hint icon
            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl })
            end

            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostics at line" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostics" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostics" })

            local null_ls = require("null-ls")
            local sources = {}

            -- Diagnostics
            table.insert(sources, null_ls.builtins.diagnostics.selene) -- Lua
            table.insert(sources, null_ls.builtins.diagnostics.ruff) -- Python
            table.insert(sources, null_ls.builtins.diagnostics.clang_check) -- C/C++
            table.insert(sources, null_ls.builtins.diagnostics.markdownlint) -- Markdown
            table.insert(sources, null_ls.builtins.diagnostics.actionlint) -- Github actions
            table.insert(sources, null_ls.builtins.diagnostics.checkmake) -- Makefile
            table.insert(sources, null_ls.builtins.diagnostics.cmake_lint) -- Cmake
            table.insert(sources, null_ls.builtins.diagnostics.cmake_lint) -- Cmake


            -- Code actions
            table.insert(sources, null_ls.builtins.code_actions.gitsigns)
            table.insert(sources, null_ls.builtins.code_actions.refactoring)

            null_ls.setup({
                sources = sources,
                diagnostics_format = "[#{c}] #{m} (#{s})",
                debug = false,
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