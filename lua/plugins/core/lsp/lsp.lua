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

            -- TODO: See rest of the shit on the branch

            vim.lsp.config('pyright', {
                settings = {
                    python = {
                        pythonPath = vim.fn.exepath("uv") .. " run python"
                    }
                }
            })
			for _, server in ipairs({ "clangd", "julials", "texlab" }) do
				vim.lsp.enable(server)
			end
		end,
	},
}

