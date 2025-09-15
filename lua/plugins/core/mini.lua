return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        config = function()
            require("mini.animate").setup({
                cursor = { enable = false },
                resize = { enable = false },
            })

            require("mini.surround").setup()

            require("mini.files").setup({
                options = {
                    use_as_default_explorer = true,
                    permanent_delete = true,
                    permanent_create = true,
                },
                windows = {
                    preview = true,
                    width_focus = 50,
                    width_preview = 50,
                    width_nofocus = 30,
                },
                mappings = {
                    go_in = "L",
                    go_out = "H",
                    show_help = "g?",
                },
            })

            require("mini.diff").setup({
                view = {
                    style = "sign",
                    signs = {
                        add = '│',
                        change = '│',
                        delete = '│',
                    }
                }
            })

            require("mini.git").setup({
                auto_open = true,
            })

            require("mini.tabline").setup({
                tabpage_section = "left",
                show_icons = true,
            })


            require("mini.pairs").setup({
                modes = { insert = true, command = true, terminal = true },
                mappings = {
                    ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
                    ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
                    ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
                    [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
                    [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
                    ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
                    ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].' },
                    ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].' },
                    ['$'] = { 
                        action = 'closeopen', 
                        pair = '$$', 
                        neigh_pattern = '[^\\].',
                        filetype = { 'tex', 'latex' }
                    },
                },
            })

            -- Disables single quote pairing in TeX files
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "tex", "latex" },
                callback = function()
                    local mp = require("mini.pairs")
                    mp.unmap(0, "'")
                end,
            })
        end,
    },
}