return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = { 
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-path", 
            "hrsh7th/cmp-buffer", 
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp", 
            "hrsh7th/cmp-nvim-lsp-signature-help", 
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                event = { "InsertEnter", "CmdlineEnter" },
                build = "make install_jsregexp",
                
                config = function()
                    -- Load snippets from the directory
                    require("luasnip.loaders.from_snipmate").load({
                        paths = { "~/.config/nvim/snippets/" },
                    })

                    -- Create snippet reload command
                    vim.api.nvim_create_user_command(
                        "ReloadSnippets", 
                        function()
                            require("luasnip.loaders.from_snipmate").load({
                                paths = { "~/.config/nvim/snippets/" },
                            })
                            print("Snippets reloaded for " .. vim.bo.filetype)
                        end, { desc = "Reload snippets for current filetype" }
                    )
                end
            },
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            vim.opt.completeopt = { "menu", "menuone", "noselect" }

            local cmp_sources = {}
            table.insert(cmp_sources, { name = "luasnip", group_index = 1 })
            table.insert(cmp_sources, { name = "buffer", group_index = 2 })
            table.insert(cmp_sources, { name = "path", group_index = 2 })
            table.insert(cmp_sources, { name = "nvim_lsp", group_index = 1 })
            table.insert(cmp_sources, { name = "nvim_lsp_signature_help", group_index = 1 })
            table.insert(cmp_sources, { name = "avante", group_index = 1 })

            local function has_words_before()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            -- Icons
            local kind_icons = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
            }

            cmp.setup({
                experiemental = {
                    ghost_text = false,
                },
                window = {
                    documentation = {
                        border = "solid",
                    },
                    completion = {
                        col_offset = -3,
                        side_padding = 0,
                        winhighlight = "Normal:NormalFloat,NormalFloat:Pmenu,Pmenu:NormalFloat",
                    },
                },
                view = {
                    entries = {
                        name = "custom",
                        selection_order = "near_cursor",
                    }
                },
                enabled = function()
                    local context = require("cmp.config.context")
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    end
                    return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                end,
                preselect = cmp.PreselectMode.None,
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                mapping = {
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = false,
                    }),
                    ["<C-e>"] = function(fallback)
                        if cmp.visible() then
                            cmp.mapping.close()
                            vim.cmd("stopinsert")
                        else
                            fallback()
                        end
                    end,
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s", "c" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s", "c" }),
                },

                sources = cmp_sources,

                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(_, vim_item)
                        vim_item.menu = vim_item.kind
                        vim_item.kind = kind_icons[vim_item.kind] or vim_item.kind
                        return vim_item
                    end,
                },
            })

            -- Command-line completions (copying nyoom's cmdline setup)
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer", group_index = 1 }
                },
            })
            
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "path" },
                    { name = "cmdline", group_index = 1 }
                },
            })
        end,
    },
}