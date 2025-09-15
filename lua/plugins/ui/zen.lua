return {
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({
                window = {
                    backdrop = 0.95,
                    width = 0.95,
                    height = 0.95,
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
}