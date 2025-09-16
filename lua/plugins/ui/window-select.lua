return {
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        keys = { "<leader>w" },
        config = function()
            require("window-picker").setup({
                hint = 'floating-big-letter',
                selection_chars = 'FJDKSLA;CMRUEIWOQP',
                picker_config = {
                    statusline_winbar_picker = {
                        selection_display = function(char, windowid)
                            return '%=' .. char .. '%='
                        end,
                        use_winbar = 'never',
                    }
                },
                show_prompt = false,
                filter_rules = {
                    autoselect_one = true,
                    include_current_win = true,
                    bo = {
                        filetype = { 'neo-tree', 'neo-tree-popup', 'notify', 'NvimTree' },
                        buftype = { 'terminal', 'quickfix' },
                    },
                },
                highlights = {
                    statusline = {
                        focused = {
                            fg = '#ededed',
                            bg = '#e35e4f',
                            bold = true,
                        },
                        unfocused = {
                            fg = '#ededed',
                            bg = '#44cc41',
                            bold = true,
                        },
                    },
                    winbar = {
                        focused = {
                            fg = '#ededed',
                            bg = '#e35e4f',
                            bold = true,
                        },
                        unfocused = {
                            fg = '#ededed',
                            bg = '#44cc41',
                            bold = true,
                        },
                    },
                }
            })

            vim.keymap.set('n', '<leader>w', function()
                local picked_window = require('window-picker').pick_window()
                if picked_window then
                    vim.api.nvim_set_current_win(picked_window)
                end
            end, { desc = "Pick window" })
        end
    }
}
