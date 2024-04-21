-- Author: Matthew Meeker


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


require("lazy").setup({
  --- Colorschemes
  "shaunsingh/nord.nvim",
  "sainnhe/everforest",
  "morhetz/gruvbox",
  "folke/tokyonight.nvim",
  "aktersnurra/no-clown-fiesta.nvim",

  -- Core


  "norcalli/nvim-colorizer.lua",
  {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons"
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return require("util.dashboard").status()
        end,
      })

      local error_color = LazyVim.ui.fg("DiagnosticError")
      local ok_color = LazyVim.ui.fg("DiagnosticInfo")
    end,
  },





  -- Telescope




  -- LSP
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "asm_lsp",
        "clangd",
        "cmake",
        "gopls"
        "hls",
        "julials",
        "marksman",
        "ocamllsp",
        "pyright",
        "rust_analyzer",
        "solang",
        "solc",
        "sumneko_lua",
        "texlab",
      })
    end,
  },
  "williamboman/mason-lspconfig.nvim",

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      ---@type lspconfig.options
      servers = {
        asm_lsp = {},
        bashls = {},
        clangd = {},
        -- ruff_lsp = {},
        marksman = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      },
      setup = {},
    },
  },
  

  { -- nvim-cmp so nice!
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
  },

  -- Niceties
  { -- Faster un/commenting for lines
    "terrortylor/nvim-comment"
  },
  "karb94/neoscroll.nvim",
  "folke/twilight.nvim",
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

})
