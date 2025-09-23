return {

	{
		"neovim/nvim-lspconfig",
		config = function()
            -- LSP handler UI improvements
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded"
            })
            
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded"
            })

            -- TODO: See rest of the shit on the branch

            vim.lsp.config('pyright', {
                settings = {
                    python = {
                        pythonPath = vim.fn.exepath("uv") .. " run python"
                    }
                }
            })
			for _, server in ipairs({ "clangd", "julials", "texlab" }) do
				vim.lsp.enable(server)
			end
		end,
	},
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
					-- Load snippets from snippets/
					require("luasnip.loaders.from_snipmate").load({
						paths = { "~/.config/nvim/snippets/" },
					})

					vim.api.nvim_create_user_command("ReloadSnippets", function()
						require("luasnip.loaders.from_snipmate").load({
							paths = { "~/.config/nvim/snippets/" },
						})
						print("Snippets reloaded for " .. vim.bo.filetype)
					end, { desc = "Reload snippets for current filetype" })
				end,
			},
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
            local lspkind = require("lspkind")

			vim.opt.completeopt = { "menu", "menuone", "noselect" }

			local cmp_sources = {}
			table.insert(cmp_sources, { name = "luasnip", group_index = 1 })
			table.insert(cmp_sources, { name = "avante", group_index = 1 })
			table.insert(cmp_sources, { name = "nvim_lsp", group_index = 1 })
			table.insert(cmp_sources, { name = "nvim_lsp_signature_help", group_index = 1 })

			table.insert(cmp_sources, { name = "buffer", group_index = 2 })
			table.insert(cmp_sources, { name = "path", group_index = 2 })

            local function has_words_before()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

			cmp.setup({
                experimental = {
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
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-e>"] = function(fallback)
                        if cmp.visible() then
                            cmp.mapping.close()
                            vim.cmd("stopinsert")
                        else
                            fallback()
                        end
                    end,
					["<CR>"] = cmp.mapping.confirm({ 
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = false 
                    }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if require("luasnip").expand_or_jumpable() then
							require("luasnip").expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
							fallback()
						end
					end, { "i", "s", "c" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if require("luasnip").jumpable(-1) then
							require("luasnip").jump(-1)
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s", "c" }),
				}),
				sources = cmp_sources,

                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                    })
                },
			})

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

