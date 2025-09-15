return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        config = function()
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