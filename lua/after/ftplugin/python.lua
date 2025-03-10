-- Python-specific settings
vim.opt_local.expandtab = false    -- Use actual tabs
vim.opt_local.tabstop = 4          -- Python standard
vim.opt_local.shiftwidth = 4 


-- Set visual column marker at 120 characters
vim.opt.colorcolumn = "120"

-- Format with Ruff
-- vim.keymap.set("n", "<leader>rf", function()
--   vim.lsp.buf.format({ async = true })
-- end, { buffer = true, desc = "Format Python code with Ruff" })

-- Create this file if it doesn't exist
-- This filters diagnostics by source
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function()
    -- Get all diagnostics
    local diagnostics = vim.diagnostic.get()
    
    -- Filter out all Pyright diagnostics
    local filtered_diagnostics = {}
    for _, diagnostic in ipairs(diagnostics) do
      if diagnostic.source ~= "Pyright" then
        table.insert(filtered_diagnostics, diagnostic)
      end
    end
    
    -- Replace all diagnostics with the filtered ones
    vim.diagnostic.set(nil, filtered_diagnostics)
  end
})