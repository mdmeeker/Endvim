-- Add filetype detection for snippet files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.snippets" },
  callback = function()
    vim.opt_local.filetype = "snippets"
  end,
})

-- Ensure Python files are detected correctly
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.py", "*.pyw" },
  callback = function()
    vim.opt_local.filetype = "python"
  end,
}) 