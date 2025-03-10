-- Format and organize imports using direct Ruff CLI commands
vim.keymap.set('n', '<leader>rf', function()
  local file = vim.fn.expand('%:p')
  local ruff_binary = vim.fn.stdpath("data") .. "/mason/bin/ruff"
  
  -- Run ruff to organize imports first
  vim.fn.system(ruff_binary .. " --select I --fix " .. file)
  
  -- Then run formatter
  vim.fn.system(ruff_binary .. " format " .. file)
  
  -- Reload the buffer to show changes
  vim.cmd("e!")
end, { buffer = true, desc = "Sort imports and format with Ruff CLI" }) 