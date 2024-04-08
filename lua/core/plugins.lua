-- Author: Matthew Meeker


local fn = vim.fn

-- If packer is not found in the path described below, installs and asks the user
-- to restart nvim
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- pcall on Packer and initialization
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}


-- These define bits s.t. commands upon which to load plugins
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


-- Finally, call Packer with the following packages
return packer.startup(function(use)

  -- Core
  use "wbthomason/packer.nvim"
  use {
    "nvim-lua/plenary.nvim",
    module = "plenary"
  }

  -- Aesthetics
  use "norcalli/nvim-colorizer.lua"
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons"
  }
  --- Colorschemes
  use "shaunsingh/nord.nvim"
  use "sainnhe/everforest"
  use "morhetz/gruvbox"
  use "folke/tokyonight.nvim"
  use "aktersnurra/no-clown-fiesta.nvim"

  use "lukas-reineke/indent-blankline.nvim"

  -- Mappings
  use {
    "anuvyklack/hydra.nvim",
    keys = "<space>",
    -- config = load file
  }
  use { -- Autopairs e.g. {}, [], (), "", ''
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require "configs/autopairs"
    end
  }
  use { -- Faster un/commenting for lines
    "terrortylor/nvim-comment"
  }
  use "karb94/neoscroll.nvim"


  -- File Navigation
  -- nvim tree
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
      -- require the nvim tree setup file
    end
  }
  -- telescope: telescope-project, telescope-ui-select, telescope-fzfnative
  
  -- Treesitter
  use { -- Treesitter and related subpackages
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    cmd = treesitter_cmds,
    module = "nvim-treesitter",
    config = function()
      -- 
    end,
    setup = function()

    end,
    requires = {
      {"nvim-treesitter/playground", cmd = "TSPlayground"},
      {"p00f/nvim-ts-rainbow", after = "nvim-treesitter"},
      {"nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter"}
    }
  }
  
  -- LSP
  use { -- Mason package manager
    "williamboman/mason.nvim",
    cmd = mason_cmds,
    config = function()
      require "configs/mason"
    end
  }
  use {
    "j-hui/fidget.nvim",
    after = "nvim-lspconfig",
    -- config = call setup
  }
  use {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    after = "nvim-lspconfig",
    -- config = call setup for lsp_lines
  }
  use {
    "neovim/nvim-lspconfig",
    opt = true,
    setup = function()
      -- TODO -- lazy loading things
    end,
    config = function()
      require("configs/lsp")
    end

  }
  

  -- Git
  use { -- Neogit
    "TimUntersberger/neogit",
    config = function()
      -- TODO -- Call setup
    end,
  }
  use { -- Gitsigns
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    -- config = call setup
    -- setup = lazy loading things
  }
  
  -- Completion
  use { -- nvim-cmp so nice!
    "hrsh7th/nvim-cmp",
    -- config = load file cmp
    wants = "LuaSnip",
    even = "InsertEnter",
    requires = {
      {"hrsh7th/cmp-path", after = "nvim-cmp"},
      {"hrsh7th/cmp-buffer", after = "nvim-cmp"},
      {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"},
      {"saadparwaiz1/cmp_luasnip", after = "nvim-cmp"},
      {"lukas-reineke/cmp-under-comparator", module = "cmp-under-comparator"},
      {"L3MON4D3/LuaSnip", 
        event = "InsertEnter", 
        wants = "friendly-snippets", 
        -- config = load-file luasnip
        requires = {
          {"rafamadriz/friendly-snippets"}
        }
      },
    }
  }

  -- More aesthetic items
  use { -- Zen mode for writing
    "Pocco81/true-zen.nvim",
    cmd = "TZAtaraxis",
    -- config = load file
  }
  use { -- Match parentheses
    "monkoose/matchparen.nvim",
    opt = true,
    -- config = load file
    -- TODO for setup -> lazyload things
  }
  use { "b0o/incline.nvim" }


  -- Orgmode
  use { -- Neorg
    "nvim-neorg/neorg",
    config = function()
      require("configs/neorg")
    end,
    ft = "neorg",
    after = "nvim-treesitter"
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
