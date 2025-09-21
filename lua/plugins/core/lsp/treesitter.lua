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
            { "nvim-treesitter/nvim-treesitter-textobjects", cmd = "TSPlayground" },
            "HiPhish/rainbow-delimiters.nvim",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-refactor",
            "nvim-treesitter/nvim-treesitter-textobjects",
            { "ggandor/leap-ast.nvim", optional = true },
        },
        opts = {
            ensure_installed = { "cpp", "python", "julia", "typst", "org", "markdown", "markdown_inline" },
            highlight = { enable = true, additional_vim_regex_highlighting = { "org", "markdown", "markdown_inline" } },
            fold = { enable = true }
        },

        config = function()
            vim.g.skip_ts_context_commentstring_module = true
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })


            local treesitter_filetypes = {
                "vimdoc", "fennel", "vim", "regex", "query",
                "c", "cpp", "rust", "toml", "lua", "python",
                "julia", "bash", "markdown", "markdown_inline",
                "json", "yaml", "latex", "typst", "git_rebase",
                "gitattributes", "gitcommit",
            }

            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

            -- Neorg parser
            parser_config.norg = {
                install_info = {
                    url = "https://github.com/nvim-neorg/tree-sitter-norg",
                    files = { "src/parser.c", "src/scanner.cc" },
                    branch = "dev",
                    use_makefile = true,
                },
            }

            parser_config.norg_meta = {
                install_info = {
                    url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
                    files = { "src/parser.c" },
                    branch = "main",
                }
            }

            parser_config.norg_table = {
                install_info = {
                    url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
                    files = { "src/parser.c" },
                    branch = "main",
                }
            }

            table.insert(treesitter_filetypes, "norg")
            table.insert(treesitter_filetypes, "norg_meta")
            table.insert(treesitter_filetypes, "norg_table")

            local has_leap_ast, leap_ast = pcall(require, "leap-ast")
            if has_leap_ast then
                vim.keymap.set({ "n", "x", "o" }, "gs", leap_ast.leap, { desc = "Leap AST" })
            end

            require("nvim-treesitter.configs").setup({
                ensure_installed = treesitter_filetypes,

                highlight = {
                    enable = true,
                    use_languagetree = true,
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
                    lint_events = { "BufWrite", "CursorHold" },
                },

                rainbow = {
                    enable = true,
                    query = {
                        "rainbow-parens",
                        html = "rainbow-tags",
                        tsx = "rainbow-tags",
                        vue = "rainbow-tags",
                    }
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