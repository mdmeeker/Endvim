return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup({ settings = { python = { pythonPath = vim.fn.exepath("uv") .. " run python" } } })
            for _, server in ipairs({ "clangd", "julials", "texlab" }) do
                lspconfig[server].setup({})
            end
        end,
    },
}