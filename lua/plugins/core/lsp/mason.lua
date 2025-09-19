return {
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonLog" },
        config = function()
            require("mason").setup({
                ui = { 
                    border = "solid",
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
            local mason_tools = {}
            -- CC
            table.insert(mason_tools, "clangd")
            table.insert(mason_tools, "clang-format")
            table.insert(mason_tools, "codelldb")
            
            -- Julia
            table.insert(mason_tools, "julia-lsp")

            -- JSON
            table.insert(mason_tools, "json-lsp")
            
            -- Latex
            table.insert(mason_tools, "texlab")
            
            -- Lua
            table.insert(mason_tools, "lua-language-server")
            table.insert(mason_tools, "stylua")
            
            -- Markdown
            table.insert(mason_tools, "marksman")
            table.insert(mason_tools, "markdownlint")

            -- Python
            table.insert(mason_tools, "ruff")
            table.insert(mason_tools, "python-lsp-server")
            table.insert(mason_tools, "debugpy")

            -- Rust
            table.insert(mason_tools, "rust-analyzer")
            table.insert(mason_tools, "rustfmt")

            -- Bash/sh
            table.insert(mason_tools, "bash-language-server")
            table.insert(mason_tools, "shfmt")

            -- YAML
            table.insert(mason_tools, "yaml-language-server")

            require("mason-tool-installer").setup({
                ensure_installed = mason_tools,
                auto_update = false,
                run_on_start = true,
                start_delay = 3000,
                debounce_hours = 168,
            })
        end
    },
}