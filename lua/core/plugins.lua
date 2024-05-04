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

  -- Telescope


  -- MASON
  "williamboman/mason.nvim",
    -- LSP   

    -- Formatter

    -- Other linter

  -- Completion

  -- Niceties
  -- "folke/twilight.nvim",
  -- {
  --   "folke/zen-mode.nvim",
  --   cmd = "ZenMode",
  --   opts = {
  --     plugins = {
  --       gitsigns = true,
  --       kitty = { enabled = false, font = "+2" },
  --     },
  --   },
  --   keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  -- },

})
