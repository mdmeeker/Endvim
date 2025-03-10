local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 1000 },
    { name = 'luasnip', priority = 750 },
    { name = 'buffer', priority = 500 },
    { name = 'path', priority = 250 },
  }),
  experimental = {
    ghost_text = true,
  }
})

-- Use buffer source for `/` and `?`

-- Fix the cmp-nvim-lsp error with Ruff
-- local orig_get_trigger_characters = require('cmp_nvim_lsp.source').get_trigger_characters
-- require('cmp_nvim_lsp.source').get_trigger_characters = function(server_name)
--   local chars
--   local ok, result = pcall(function()
--     return orig_get_trigger_characters(server_name)
--   end)
--   if ok then
--     chars = result
--   else
--     -- Fallback to reasonable defaults
--     chars = { '.', ':' }
--     print("Handled cmp-nvim-lsp error gracefully for " .. (server_name or "unknown server"))
--   end
--   return chars
-- end

-- Add this debugging command
vim.api.nvim_create_user_command("CheckCompletion", function()
  local bufnr = vim.api.nvim_get_current_buf()
  print("Current sources for completion:", vim.inspect(cmp.get_config().sources))
  print("LSP clients:", vim.inspect(vim.lsp.get_active_clients({bufnr = bufnr})))
end, {})