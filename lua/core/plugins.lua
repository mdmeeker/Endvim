local treesitter_cmds = {
  "TSInstall",
  "TSBufEnable",
  "TSBufDisable",
  "TSEnable",
  "TSDisable",
  "TSModuleInfo",
}

local mason_cmds = {
  "Mason",
  "MasonInstall",
  "MasonInstallAll",
  "MasonUninstall",
  "MasonUninstallAll",
  "MasonLog",
}


require("lazy").setup({
  --- Colorschemes
  "shaunsingh/nord.nvim",
  "aktersnurra/no-clown-fiesta.nvim",
  "nyoom-engineering/oxocarbon.nvim",
  "sainnhe/sonokai",

  -- Core
  "norcalli/nvim-colorizer.lua",
  {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons"
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" }
  },
  {
    "b0o/incline.nvim",
    config = function()
      require('incline').setup()
    end,
  },


  "nvim-treesitter/nvim-treesitter",
  
  -- Nice scrolling
  "karb94/neoscroll.nvim",
  -- Dashboard
  "goolord/alpha-nvim",
  -- Terminal emulator splits
  {'akinsho/toggleterm.nvim', version = "*", config = true},
  -- Commenting
  {
    'numToStr/Comment.nvim',
    lazy = false,
  },

  "nvim-tree/nvim-tree.lua",

  -- Telescope


  -- Completions 
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",

  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",


  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    -- init = function()
      -- VimTeX configuration goes here
    -- end
  },

  "folke/twilight.nvim",
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

})
