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


lspconfig.ruff.setup({
  init_options = {
    settings = {

    }
  }
})


-- ... other language server setups can go here ... 