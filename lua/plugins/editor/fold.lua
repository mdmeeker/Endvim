return {
    -- Enhanced folding with nvim-ufo
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
        "kevinhwang91/promise-async",
        "nvim-treesitter/nvim-treesitter",
        },
        event = "BufReadPost",
        config = function()
        -- Copy nyoom's vim settings
            vim.opt.foldcolumn = "1"
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
            vim.opt.foldenable = true

            local ufo = require("ufo")
            
            -- Copy nyoom's keybindings
            vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
            vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })

            -- Copy nyoom's setup with provider selector
            ufo.setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { "treesitter", "indent" }
                end,
            })
        end,
    },
}