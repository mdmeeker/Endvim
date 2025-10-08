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
					-- Safe snippet loading with error handling
					local success, loader = pcall(require, "luasnip.loaders.from_snipmate")
					if success then
						local snippet_path = vim.fn.expand("~/.config/nvim/snippets/")
						if vim.fn.isdirectory(snippet_path) == 1 then
							local load_success = pcall(loader.load, {
								paths = { snippet_path },
							})
							if not load_success then
								vim.notify("Failed to load snippets from " .. snippet_path, vim.log.levels.WARN)
							end
						else
							vim.notify("Snippet directory not found: " .. snippet_path, vim.log.levels.WARN)
						end
					else
						vim.notify("Failed to load LuaSnip loader", vim.log.levels.ERROR)
					end

					vim.api.nvim_create_user_command("ReloadSnippets", function()
						local success, loader = pcall(require, "luasnip.loaders.from_snipmate")
						if success then
							local snippet_path = vim.fn.expand("~/.config/nvim/snippets/")
							if vim.fn.isdirectory(snippet_path) == 1 then
								local load_success = pcall(loader.load, {
									paths = { snippet_path },
								})
								if load_success then
									print("Snippets reloaded for " .. vim.bo.filetype)
								else
									vim.notify("Failed to reload snippets", vim.log.levels.ERROR)
								end
							else
								vim.notify("Snippet directory not found", vim.log.levels.ERROR)
							end
						else
							vim.notify("Failed to load snippet loader", vim.log.levels.ERROR)
						end
					end, { desc = "Reload snippets for current filetype" })
				end,
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

			-- Safe buffer access function
			local function has_words_before()
				local success, line, col = pcall(vim.api.nvim_win_get_cursor, 0)
				if not success or col == 0 then
					return false
				end
				
				local success, lines = pcall(vim.api.nvim_buf_get_lines, 0, line - 1, line, true)
				if not success or #lines == 0 then
					return false
				end
				
				local char = lines[1]:sub(col, col)
				return char and char:match("%s") == nil
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
						max_item_count = 7,
					},
				},

				enabled = function()
					local context = require("cmp.config.context")
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					end
					return not context.in_treesitter_capture("comment")
						and not context.in_syntax_group("Comment")
						and not context.in_syntax_group("String")
				end,

				preselect = cmp.PreselectMode.None,

				snippet = {
					expand = function(args)
						local success = pcall(luasnip.lsp_expand, args.body)
						if not success then
							vim.notify("Failed to expand snippet", vim.log.levels.WARN)
						end
					end,
				},

				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = false,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s", "c" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s", "c" }),
				}),

				sources = cmp_sources,

				formatting = {
					field = { "kind", "abbr", "menu" },
					format = function(_, vim_item)
						vim_item.menu = vim_item.kind
						vim_item.kind = kind_icons[vim_item.kind] or vim_item.kind
						return vim_item
					end,
				},
			})

			-- Cmdline completion setup
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

