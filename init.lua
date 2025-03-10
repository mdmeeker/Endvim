-- Nvim configuration

require('core.options')     -- Basic options
require('core.keymaps')     -- Key mappings
require('core.plugins')     -- All plugins + lazy.nvim
require('core.colorscheme')

-- Wait for lazy.nvim to load plugins before configuring them
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Plugin configurations
    require('plugins.lsp')        -- Load LSP first
    require('plugins.completion') -- Then load completion
    require('plugins.nvim-tree')  -- Load other plugins last
  end,
})


