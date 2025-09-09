return {
    -- Colorscheme
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function() 
            vim.g.everforest_background = "hard"
            vim.g.everforest_better_performance = 1
            vim.cmd("colorscheme everforest")
        end,
    },

    -- Icons
    { "DaikyXendo/nvim-material-icon" },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim", 
        dependencies = { "nvim-lua/plenary.nvim" }, 
        cmd = "Telescope", 
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
        },
        extensions = {
            orgmode = {
                export_directory = "~/org/export",
            }
        }
    },

    -- WhichKey
    { 
        "folke/which-key.nvim", 
        config = function()
            require("which-key").setup({
                plugins = {
                    spelling = true
                },
                win = {
                    border = "rounded",
                },
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
                        showcmd = false,
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
                        position = { 
                            row = "50%", 
                            col = "50%",
                        },
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
    }
}