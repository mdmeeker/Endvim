return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
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
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            local cmp_sources = cmp.config.sources({
                { name = "nvim_lsp", max_item_count = 6 },
                { name = "luasnip",  max_item_count = 6 },
            }, {
                { name = "buffer",   max_item_count = 3, keyword_length = 3 },
                { name = "path",     max_item_count = 3 },
            })
            
            cmp.setup({
                sources = cmp_sources,

                performance = {
                    max_view_entries = 8,  -- show at most 8 items in the menu
                },

                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"
                
                        return kind
                    end,
                },

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