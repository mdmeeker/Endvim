return {
    {
        "nvim-treesitter/nvim-treesitter",
        cmd = {
            "TSInstall",
            "TSUpdate",
            "TSInstallSync",
            "TSUpdateSync",
            "TSBufEnable",
            "TSBufDisable",
            "TSEnable",
            "TSDisable",
            "TSModuleInfo",
        },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-refactor",
            { "ggandor/leap-ast.nvim", optional = true },
            {
                "HiPhish/rainbow-delimiters.nvim",
                version = "*",
                optional = true,
            },
        },
        config = function()
            -- Context commentstring setup
            vim.g.skip_ts_context_commentstring_module = true
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })

            -- Leap AST integration
            local has_leap_ast, leap_ast = pcall(require, "leap-ast")
            if has_leap_ast then
                vim.keymap.set({ "n", "x", "o" }, "gs", leap_ast.leap, { desc = "Leap AST" })
            end

            -- Main treesitter configuration
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vimdoc", "fennel", "vim", "regex", "query",
                    "c", "cpp", "rust", "toml", "lua", "python",
                    "julia", "bash", "markdown", "markdown_inline",
                    "json", "yaml", "latex", "typst", "git_rebase",
                    "gitattributes", "gitcommit",
                },

                highlight = {
                    enable = true,
                    use_languagetree = true,
                    additional_vim_regex_highlighting = { "org", "markdown", "markdown_inline" },
                    disable = { "latex" },
                },

                indent = {
                    enable = true,
                    disable = { "latex" },
                },

                refactor = {
                    enable = true,
                    keymaps = {
                        smart_rename = "<localleader>rn",
                    },
                },

                query_linter = {
                    enable = true,
                    use_virtual_text = true,
                    lint_events = { "BufWrite" },
                },

                rainbow = {
                    enable = true,
                    query = "rainbow-parens",
                },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                },
            })
        end,
    },
}