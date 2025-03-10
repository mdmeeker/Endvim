require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "ruff",          -- Python
    "clangd",        -- C/C++
    "julia_lsp",     -- Julia
    "rust_analyzer", -- Rust
    "ocamllsp",      -- OCaml
    "hls",           -- Haskell
    "asm_lsp",       -- Assembly
    -- TODO: add markdown, restructured text, zig?
  }
})

local lspconfig = require('lspconfig')

-- Ruff configuration
lspconfig.ruff.setup({
  settings = {
    -- Ruff settings
    ruff = {
      -- Enable Ruff's formatter
      format = {
        enabled = true,
      },
      -- Enable Ruff's linter
      lint = {
        enabled = true,
      },
      -- Configure rules, severity, etc.
      rules = {
        -- Add any specific rules you want to enable/configure
      },
    }
  },
  on_attach = function(client, bufnr)
    -- Enable formatting
    client.server_capabilities.documentFormattingProvider = true
    
    -- Set up buffer-local keymaps, etc.
    local opts = { buffer = bufnr }
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- Global mappings for LSP
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})

-- ... other language server setups can go here ... 