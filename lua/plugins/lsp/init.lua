-- Basic Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ruff", "pyright" }
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Enable debug logging for LSP
vim.lsp.set_log_level("debug")

-- Add this at the top of the file, after requires
local pyright_ns = vim.api.nvim_create_namespace("pyright_diagnostics")

-- Ruff configuration with better persistence
lspconfig.ruff.setup({
  capabilities = capabilities,
  settings = {
    ruff = {
      -- Keep server alive
      serverAliveInterval = 300, -- 5 minutes
    }
  },
  -- More reliable root_dir detection
  root_dir = function(fname)
    return lspconfig.util.root_pattern(".git", "pyproject.toml", "setup.py")(fname) or vim.fn.getcwd()
  end,
  -- Prevent timeout
  flags = {
    debounce_text_changes = 150,
    allow_incremental_sync = true,
    exit_timeout = false, -- Prevent automatic shutdown
  },
  on_attach = function(client, bufnr)
    -- Disable Ruff completions
    client.server_capabilities.completionProvider = false
    
    -- Format keymap for Python files
    vim.keymap.set('n', '<leader>rf', function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = "Format Python code with Ruff" })
  end,
})

-- Add Pyright configuration for Python intellisense
lspconfig.pyright.setup({
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        -- Keep all the diagnostic severity overrides
      },
    },
  },
  handlers = {
    -- Override the default diagnostic handler to discard all diagnostics
    ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
      -- Only process diagnostics from Pyright
      if ctx.client_id and vim.lsp.get_client_by_id(ctx.client_id).name == "pyright" then
        -- Just ignore all diagnostics from Pyright
        return
      end
      
      -- For other LSPs, use the default handler
      return vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    end,
  },
  on_attach = function(client, bufnr)
    -- Disable Pyright formatting in favor of Ruff
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    
    -- Disable diagnostics capabilities
    client.server_capabilities.diagnosticProvider = false
    
    -- Clear any existing diagnostics from Pyright's namespace
    vim.diagnostic.reset(pyright_ns, bufnr)
    
    -- Add a buffer-local autocmd to clear Pyright diagnostics on change
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = bufnr,
      callback = function()
        vim.diagnostic.reset(pyright_ns, bufnr)
      end
    })
  end,
})

-- Periodically check if Ruff is still attached
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*.py",
  callback = function(ev)
    local clients = vim.lsp.get_active_clients({bufnr = ev.buf})
    local has_ruff = false
    for _, client in ipairs(clients) do
      if client.name == "ruff" then has_ruff = true; break end
    end
    
    if not has_ruff and vim.bo[ev.buf].filetype == "python" then
      vim.cmd("LspStart ruff")
    end
  end
})

-- Add an auto-attached function for Pyright to match what we did for Ruff
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*.py",
  callback = function(ev)
    local clients = vim.lsp.get_active_clients({bufnr = ev.buf})
    local has_pyright = false
    for _, client in ipairs(clients) do
      if client.name == "pyright" then has_pyright = true; break end
    end
    
    if not has_pyright and vim.bo[ev.buf].filetype == "python" then
      vim.cmd("LspStart pyright")
    end
  end
})

-- Global LSP keymaps
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Buffer-specific LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
}) 