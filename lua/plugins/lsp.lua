return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "texlab", "ruff", "clangd", "julials" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
        local lspconfig = require("lspconfig")
        lspconfig.pyright.setup({ settings = { python = { pythonPath = vim.fn.exepath("uv") .. " run python" } } })
        for _, server in ipairs({ "clangd", "julials", "texlab" }) do
            lspconfig[server].setup({})
        end
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip" },
        config = function()
            -- Load snippets from snippets/
            require("luasnip.loaders.from_snipmate").lazy_load({
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
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif require("luasnip").expand_or_jumpable() then
                                require("luasnip").expand_or_jump()
                            else
                                fallback()
                            end
                        end,
                        { "i", "s" }
                    ),
                    ["<S-Tab>"] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif require("luasnip").jumpable(-1) then
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
                    { name = "luasnip", option = { show_autosnippets = true } },  -- Prioritize and show snippets more prominently
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
            ensure_installed = { "cpp", "python", "julia", "latex", "typst", "org" },
            highlight = { enable = true, additional_vim_regex_highlighting = { "org" } },
            fold = { enable = true }
        },
    },
}