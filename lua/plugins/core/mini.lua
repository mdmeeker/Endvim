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
    },
}