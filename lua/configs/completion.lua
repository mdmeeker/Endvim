-- Mason configuration
require("mason").setup()


local cmp = require("cmp")
cmp.setup({

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },

  window = {},

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })

})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

local servers = {
  "texlab",
  "clangd",
  "pyright",
  "julials",
  "cmake",
  "lua_ls",
  "typos_lsp",
}
require("mason-lspconfig").setup( {
  ensure_installed = servers,
})


local lspc = require("lspconfig")
lspc.pyright.setup {
  capabilities = capabilities
}
lspc.clangd.setup {
  capabilities = capabilities
}
lspc.julials.setup {
  capabilities = capabilities
}
lspc.cmake.setup {
  capabilities = capabilities
}
lspc.typos_lsp.setup {
  capabilities = capabilities
}
