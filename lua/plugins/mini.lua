return {
    {
        "nvim-mini/mini.nvim",
        version = false,

        config = function()
            require("mini.animate").setup({ cursor = { enabled = false } })
            require("mini.icons").setup()

            require("mini.surround").setup()

            require("mini.files").setup({
                options = {
                    use_as_default_explorer = true,
                },
                windows = {
                    preview = true,
                    width_focus = 20,
                    width_preview = 20,
                }
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
        end,
    }
}