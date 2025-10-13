return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                event = { 
                    "InsertEnter",
                    "CmdlineEnter",
                },
                build = "make install_jsregexp",
                
                config = function()

                end
            },
        },
        -- TODO: Play with settings here
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            local cmp_sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }
            
            cmp.setup({
                sources = cmp_sources,

                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ 
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true 
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
                        
                    end, { "i", "s", "c" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						elseif cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
                    end, { "i", "s", "c" }),
                }),

                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- Auto-select first item
                preselect = cmp.PreselectMode.Item,
                -- Auto-complete on typing
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
            })
        end,
    },
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "hrsh7th/cmp-buffer",
    },
    {
        "hrsh7th/cmp-path",
    },
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip").setup()
            
            -- Load snippets from Lua files with explicit filetype mapping
            require("luasnip.loaders.from_lua").load({
                paths = { vim.fn.stdpath("config") .. "/snippets" }
            })
            
            -- Explicitly load tex snippets for tex files
            require("luasnip").filetype_extend("tex", { "tex" })
        end,
    },
    {
        "saadparwaiz1/cmp_luasnip",
    },
}