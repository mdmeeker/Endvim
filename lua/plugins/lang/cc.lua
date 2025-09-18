return {
    {
        "p00f/clangd_extensions.nvim",
        ft = { "c", "cpp" },
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            local ok, _ = pcall(require, "lspconfig")
            if ok then
                require("clangd_extensions").setup()
            end
        end,
    },
}