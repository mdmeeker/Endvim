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

    -- Telescope
    {
        "nvim-telescope/telescope.nvim", 
        dependencies = { "nvim-lua/plenary.nvim" }, 
        cmd = "Telescope", 
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
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

    -- Dashboard with image support (random from dashboard_images, no keywords)
    {
        "goolord/alpha-nvim",
        dependencies = { "3rd/image.nvim" },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
    
            -- Set up image rendering
            require("image").setup({
                backend = "kitty",
            })
    
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
    
            -- Random image selection using vim.fn.glob (no external commands)
            local image_dir = vim.fn.expand("~/.config/nvim/dashboard_images/")
            local imgs = vim.fn.glob(image_dir .. "*.{jpg,png,jpeg}", false, true)  -- List JPGs, PNGs, JPEGs
            if #imgs == 0 then
                print("No images found in " .. image_dir)  -- Debug if none found
                return  -- Skip image if none available
            end
            local image_path = imgs[math.random(#imgs)]
    
            -- Default dimensions (fallback if magick fails)
            local image_width = 70
            local image_height = 50
    
            -- Try to get dimensions with ImageMagick (install if not present: brew install imagemagick)
            local success, dim = pcall(io.popen, "magick identify -ping -format '%w\n%h' " .. vim.fn.shellescape(image_path))
            if success and dim then
                local i_width, i_height = dim:read("*n", "*n")
                assert(dim):close()
                i_width, i_height = i_width or image_width, i_height or image_height
                if (i_width * 0.75) < i_height then
                    image_width = math.ceil(i_width / i_height * image_height)
                end
            else
                print("Warning: Could not get image dimensions (install ImageMagick?) Using defaults.")
            end
    
            -- Layout: quote > padding (for image space) > buttons
            dashboard.opts.layout = {
                { type = "padding", val = 4 },
                dashboard.section.header,
                { type = "padding", val = image_height + 2 },
                dashboard.section.buttons,
            }
    
            alpha.setup(dashboard.opts)
    
            -- Disable folding on alpha buffer
            vim.cmd([[
                autocmd FileType alpha setlocal nofoldenable
            ]])
    
            -- Image Integration
            local image = nil
    
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                desc = "Render an image on the dashboard",
                callback = function()
                    vim.go.laststatus = 0
                    vim.opt.showtabline = 0
                    vim.opt.signcolumn = "no"
                    vim.opt.foldcolumn = "0"
    
                    local buf = vim.api.nvim_get_current_buf()
                    local win = vim.api.nvim_get_current_win()
                    local win_width = vim.api.nvim_win_get_width(win)
                    print("Window width: " .. win_width .. ", Image width: " .. image_width)
    
                    -- Calculate column to center the image.
                    local col = tonumber(math.floor((win_width - image_width) / 2))
                    print("Column: " .. col)

                    -- Delay rendering so the image doesn't slow startup
                    vim.defer_fn(function()
                        if vim.api.nvim_get_current_buf() ~= buf then return end
                        image = require("image").from_file(image_path, {
                            window = win,
                            buffer = nil,
                            width = image_width,
                            height = image_height,
                            x = col,
                            y = 15,
                            with_virtual_padding = false,
                            inline = false,
                            id = image_path
                        })
                        local old_max_height_window_percentage = image.global_state.options.max_height_window_percentage
                        image.global_state.options.max_height_window_percentage = 75
                        image:render()
                        image.global_state.options.max_height_window_percentage = old_max_height_window_percentage
                    end, 150)
                end,
            })
    
            vim.api.nvim_create_autocmd("BufUnload", {
                buffer = 0,
                desc = "Cleanup image when leaving alpha",
                callback = function()
                    vim.go.laststatus = 3
                    vim.opt.showtabline = 2
                    if image then image:clear() end
                end,
            })
        end,
    },
}