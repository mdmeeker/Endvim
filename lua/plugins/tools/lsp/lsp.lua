return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = {
                    properties = {
                        "documentation",
                        "detail",
                        "additionalTextEdits",
                    }
                }
            }

            -- LSP handler UI improvements
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "solid"
            })
            
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "solid"
            })

            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, silent = true }

                vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP Hover" }))
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to Declaration" }))
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to Type Definition" }))
                vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to References" }))
                vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to Declaration" }))
                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
                vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to Type Definition" }))
                vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to References" }))

                if client.supports_method("textDocument/signatureHelp") then

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            if not vim.g.lsp_autoformat_disable then
                                vim.lsp.buf.format({ 
                                    bufnr = bufnr,
                                    filter = function(c)
                                        return not vim.tbl_contains({ "jsonls", "tsserver" }, c.name)
                                    end
                                })
                            end
                        end,
                    })
                end
            end

            local defaults = {
                on_attach = on_attach,
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150
                }
            }

            local function setup_server(server, config)
                local final_config = vim.tbl_deep_extend("force", defaults, config or {})
                lspconfig[server].setup(final_config)
            end

            -- C/C++
            setup_server("clangd", {
                cmd = { "clangd" },
            })

            -- Bash/sh
            setup_server("bashls", {})

            -- Julia
            setup_server("julials", {})

            -- JSON
            setup_server("jsonls", {
                settings = {
                    json = {
                        format = { enabled = true },
                        schemas = {
                            {
                                description = "ESLint config",
                                fileMatch = { ".eslintrc.json", ".eslintrc" },
                                url = "http://json.schemastore.org/eslintrc",
                            },
                            {
                                description = "Package config",
                                fileMatch = { "package.json" },
                                url = "https://json.schemastore.org/package"
                            },
                            -- TODO: Others
                        }
                    }
                }
            })

            -- Latex
            setup_server("texlab", {})

            -- Lua
            setup_server("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            maxPreload = 100000
                        }
                    }
                }
            })

            -- Markdown
            setup_server("marksman", {})

            -- Python with Ruff and uv
            setup_server("ruff", {
                init_options = {
                    settings = {
                        logLevel = "warn",
                        interpreter = { vim.fn.exepath("uv") .. " run python" },
                        organizeImports = true,
                        fixAll = true,
                    }
                },
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    client.server_capabilities.hoverProvider = false
                end,
            })

            setup_server("pylsp", {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = { enabled = false },
                            mccabe = { enabled = false },
                            pyflakes = { enabled = false },
                            flake8 = { enabled = false },
                            autopep8 = { enabled = false },
                            yapf = { enabled = false },

                            pylsp_mypy = {
                                enabled = true,
                                live_mode = false,
                                strict = false,
                            },
                            rope_autoimport = { enabled = true },
                        }
                    }
                }
            })

            -- YAML with schema support
            setup_server("yamlls", {
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "https://www.schemastore.org/api/json/catalog.json",
                        },
                        schemas = {
                            ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}"
                        },
                        validate = true,
                    }
                }
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { 
            "hrsh7th/cmp-nvim-lsp", 
            "hrsh7th/cmp-buffer", 
            "hrsh7th/cmp-path", 
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            -- Load snippets from snippets/
            require("luasnip.loaders.from_snipmate").load({
                paths = { "~/.config/nvim/snippets/" },
            })

            vim.api.nvim_create_user_command(
                "ReloadSnippets", 
                function()
                    require("luasnip.loaders.from_snipmate").load(
                        {
                            paths = { "~/.config/nvim/snippets/" },
                        }
                    )
                    print("Snippets reloaded for " .. vim.bo.filetype)
                end, { desc = "Reload snippets for current filetype" }
            )

            local cmp = require("cmp")
            cmp.setup({
                snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"] = cmp.mapping(
                        function(fallback)
                            if require("luasnip").expand_or_jumpable() then
                                require("luasnip").expand_or_jump()
                            else
                                fallback()
                            end
                        end,
                        { "i", "s" }
                    ),
                    ["<S-Tab>"] = cmp.mapping(
                        function(fallback)
                            if require("luasnip").jumpable(-1) then
                                require("luasnip").jump(-1)
                            else
                                fallback()
                            end
                        end, 
                        { "i", "s" }
                    ),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "avante" },
                }),
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { 
                "cpp", "python", "julia", "latex", "typst", "org", "markdown", 
                "markdown_inline", "c", "rust", "lua", "bash", "json", "yaml" 
            },
            highlight = { 
                enable = true, 
                additional_vim_regex_highlighting = { "org", "markdown", "markdown_inline" } 
            },
            fold = { enable = true }
        },
    },
}