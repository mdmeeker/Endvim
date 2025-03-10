-- Python-specific settings
vim.opt_local.expandtab = false    -- Use actual tabs
vim.opt_local.tabstop = 4          -- Python standard
vim.opt_local.shiftwidth = 4 


-- Set visual column marker at 120 characters
vim.opt.colorcolumn = "120"

-- Format with Ruff
vim.keymap.set("n", "<leader>rf", function()
  vim.lsp.buf.format({ async = true })
end, { buffer = true, desc = "Format Python code with Ruff" })