return {

	{
		"neovim/nvim-lspconfig",
		config = function()
            -- LSP handler UI improvements
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded"
            })
            
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded"
            })

            -- Modern LSP server configuration with error handling
            local servers = {
                pyright = {
                    settings = {
                        python = {
                            pythonPath = vim.fn.exepath("uv") .. " run python"
                        }
                    }
                },
                clangd = {},
                julials = {},
                texlab = {}
            }

            for server, config in pairs(servers) do
                local success = pcall(vim.lsp.config, server, config)
                if not success then
                    vim.notify("Failed to configure LSP server: " .. server, vim.log.levels.WARN)
                end
            end
		end,
	},
}

