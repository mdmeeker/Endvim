return {
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonLog" },
        config = function()
            require("mason").setup({
                ui = { 
                    border = "rounded",
                },
                PATH = "skip",
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { 
                    "clangd", "julials", "jsonls", "texlab", "lua_ls", 
                    "marksman", "ruff", "pylsp", "rust_analyzer", 
                    "bashls", "yamlls"
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "clangd", "clang-format", "clang-check", "codelldb",
                    "julia-lsp", "json-lsp", "texlab",
                    "lua-language-server", "stylua", "selene",
                    "marksman", "markdownlint",
                    "ruff", "python-lsp-server", "debugpy",
                    "rust-analyzer", "rustfmt",
                    "bash-language-server", "shfmt",
                    "yaml-language-server"
                },
                auto_update = false,
                run_on_start = true,
                start_delay = 3000,
                debounce_hours = 168,
            })
        end
    },
}