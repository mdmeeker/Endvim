return {
    {
        "aktersnurra/no-clown-fiesta.nvim",
        lazy=false,
        priority=false,
        config=function()
          vim.cmd([[colorscheme no-clown-fiesta]])
        end,
    },
    { "shaunsingh/oxocarbon" },
    { "ellisonleao/gruvbox.nvim" },
    { "sainnhe/everforest" },
    { "rose-pine/neovim", name = "rose-pine" },
}