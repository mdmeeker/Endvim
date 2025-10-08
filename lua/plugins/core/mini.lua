return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        config = function()
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