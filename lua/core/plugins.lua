-- Plugin management with lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Colorscheme
  -- FOR VIM: { "sainnhe/everforest" },
  { 
    "neanias/everforest-nvim",
    version = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "dark",
        ui_contrast = "high",
        disable_italic_comments = false,
        dim_inactive_windows = true,
        float_style = "bright",
      })
    end
  },
  
  -- Essential plugins
  { "nvim-lua/plenary.nvim" },
  
  -- LSP Support
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  
  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  
  -- Language specific
  -- Python
--   { "astral-sh/ruff-lsp" },
  -- Julia
--   { "JuliaEditorSupport/julia-vim" },
  -- C/C++
--   { "p00f/clangd_extensions.nvim" },
  -- Rust
--   { "simrat39/rust-tools.nvim" },
  -- Haskell
--   { "neovimhaskell/haskell-vim" },
  -- OCaml
--   { "ocaml/vim-ocaml" },
  -- CUDA
--   { "bfrg/vim-cuda-syntax" },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    lazy = false,
    priority = 999,
  },

  -- Dashboard
  {
    'goolord/alpha-nvim',
    dependencies = { 
      'nvim-tree/nvim-web-devicons',
      'BlakeJC94/alpha-nvim-fortune'
    },
    priority = 998,
    config = function()
      require('plugins.alpha')
    end,
  },

  -- Icons (required by both nvim-tree and alpha)
  { "nvim-tree/nvim-web-devicons", lazy = false },

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("plugins.toggleterm")
    end,
  },

  -- Smooth scrolling
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('plugins.neoscroll')
    end,
  },

}, {}) 