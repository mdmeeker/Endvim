return {
    -- WhichKey
    { 
        "folke/which-key.nvim", 
        config = function()
            local wk = require("which-key")

            wk.setup({
                plugins = {
                    spelling = true
                },
                win = {
                    border = "rounded",
                    height = { min = 5, max = 25 },
                },
            })

            wk.add({
                { "<leader>b", group = "Buffer" },
                { "<leader>l", group = "LaTeX/LSP" },
                { "<leader>t", group = "Terminal" },
                { "<leader>g", group = "Git" },
                { "<leader>z", group = "Zen Mode" },
                { "<leader>f", group = "File/Find" },
                { "<leader>o", group = "Org Mode" },
            })
        end,
    },

    -- Zen mode
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({
                window = {
                    backdrop = 0.95, -- Dim the background
                    width = 0.95,     -- Width of the zen window
                    height = 0.95,    -- Height of the zen window
                    options = {
                        number = false,
                        relativenumber = false,
                        foldcolumn = "0",
                        list = false,
                        showbreak = "",
                        signcolumn = "no",
                        wrap = true,
                        linebreak = true,
                    },
                },
                plugins = {
                    options = {
                        enabled = true,
                        ruler = false,
                        showcmd = true,
                        laststatus = 0,
                    },
                    twilight = { enabled = true },
                    gitsigns = { enabled = false },
                    tmux = { enabled = false },
                    kitty = { enabled = false },
                    alacritty = { enabled = false },
                    wezterm = { enabled = false },
                    iterm = { enabled = false },
                },
            })
        end,
    },


    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    }
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = true,
                    lsp_doc_border = true,
                },
                views = {
                    cmdline_popup = {
                        size = {
                            width = "60%",
                            height = "auto",
                        },
                        border = { style = "rounded" },
                        win_options = {
                            winhighlight = {
                                Normal = "NormalFloat",
                                FloatBorder = "FloatBorder",
                            },
                        },
                    },
                    notify = {
                        border = { style = "rounded" }
                    },
                },

                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            kind = "",
                            any = {
                                { find = "%d+ fewer lines" },
                                { find = "%d+ more lines" },
                                { find = "%d+ lines yanked" },
                                { find = "%d+ lines changed" },
                            },
                        },
                        opts = { skip = true },
                    },
                },

                require("telescope").load_extension("noice")
            })
        end
    },

    -- Dashboard with image support (random from dashboard_images, no keywords)
    {
        "goolord/alpha-nvim",
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
    
            -- Dashboard sections: Quote in header, buttons in "footer" position
            local fortune = require("alpha.fortune")
            dashboard.section.header.val = fortune()
            dashboard.section.header.opts.position = "center"
            dashboard.section.header.opts.hl = "Type"
    
            -- Dashboard sections: Buttons and fortune quote in footer
            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
                dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
                dashboard.button("q", "  Quit", ":qa<CR>"),
                -- Add more buttons here, e.g., dashboard.button("n", "  New File", ":enew<CR>"),
            }
            dashboard.section.buttons.opts.hl = "Type"
    
            -- Layout: quote > padding (for image space) > buttons
            dashboard.opts.layout = {
                { type = "padding", val = 4 },
                dashboard.section.header,
                { type = "padding", val = 4 },
                dashboard.section.buttons,
            }
    
            alpha.setup(dashboard.opts)
    
            -- Disable folding on alpha buffer
            vim.cmd([[
                autocmd FileType alpha setlocal nofoldenable
            ]])
        end,
    },



    -- Nvim-tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "DaikyXendo/nvim-material-icon" },
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        keys = {
            { "<leader>ft", ":NvimTreeToggle<CR>", desc = "Toggle nvim-tree sidebar" },
            { "<leader>fT", ":NvimTreeFocus<CR>", desc = "Focus nvim-tree sidebar" },
        },
        config = function()
            require("nvim-tree").setup({
                disable_netrw = true,
                hijack_netrw = true,
                filters = {
                    dotfiles = false,
                    git_ignored = false,
                },
                git = {
                    enable = true,
                },
                actions = {
                    open_file = {
                        quit_on_open = false,
                    },
                },
            })

            -- Auto-close if nvim-tree is the last window
            vim.api.nvim_create_autocmd("BufEnter", {
                nested = true,
                callback = function()
                    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
                        vim.cmd("quit")
                    end
                end,
            })
        end
    },

    -- ToggleTerm for floating/persistent terminals
    {
        "akinsho/toggleterm.nvim",
        keys = { 
            { "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle floating terminal" }, 
            { "<leader>tb", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle horizontal terminal" }, 
            { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Toggle vertical terminal" }, 
        },
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<C-\>]],
                shade_terminals = true,
                direction = "horizontal",
                float_opts = {
                    border = "curved",
                    width = math.floor(vim.o.columns * 0.7),
                    height = math.floor(vim.o.lines * 0.7),
                    windblend = 10,
                },
            })
        end
    }
}