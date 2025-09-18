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
            "HiPhish/nvim-ts-rainbow2",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-refactor",
            "nvim-treesitter/nvim-treesitter-textobjects",
            { "ggandor/leap-ast.nvim", optional = true },
        },
        config = function()
            local treesitter_filetypes = {
                "vimdoc", "fennel", "vim", "regex", "query",
                "c", "cpp", "rust", "toml", "lua", "python",
                "julia", "bash", "markdown", "markdown_inline",
                "json", "yaml", "latex", "typst", "git_rebase",
                "gitattributes", "gitcommit",
            }

            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

            -- TODO: Org mode parser, if needed?
            -- parser_config.org = {
            --     filetype = "org",
            --     install_info = {
            --         url = "https://github.com/emiasims/nvim-treesitter-org",
            --         files = { "src/parser.c", "src/scanner.c" },
            --         branch = "main",
            --     },
            -- }
            -- table.insert(treesitter_filetypes, "org")

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

            local function setup_rainbow_colors()
                vim.api.nvim_set_hl(0, "TSRainbowRed", { fg = "#b46958", bg = "NONE" })
                vim.api.nvim_set_hl(0, "TSRainbowYellow", { fg = "#F5BF75", bg = "NONE" })
                vim.api.nvim_set_hl(0, "TSRainbowBlue", { fg = "#BAD7FF", bg = "NONE" })
                vim.api.nvim_set_hl(0, "TSRainbowOrange", { fg = "#FFA557", bg = "NONE" })
                vim.api.nvim_set_hl(0, "TSRainbowGreen", { fg = "#90A959", bg = "NONE" })
                vim.api.nvim_set_hl(0, "TSRainbowViolet", { fg = "#AA749F", bg = "NONE" })
                vim.api.nvim_set_hl(0, "TSRainbowCyan", { fg = "#88AFA2", bg = "NONE" })
            end

            setup_rainbow_colors()

            local has_leap_ast, leap_ast = pcall(require, "leap-ast")
            if has_leap_ast then
                vim.keymap.set({ "n", "x", "o" }, "gs", leap_ast.leap, { desc = "Leap AST" })
            end

            require("nvim-treesitter.configs").setup({
                ensure_installed = treesitter_filetypes,

                highlight = {
                    enable = true,
                    use_languagetree = true,
                },

                indent = {
                    enable = true,
                },

                context_commentstring = {
                    enable = true,
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
                        latex = "rainbow-blocks",
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