return {

  ------------------
  -- COLORSCHEMES --
  ------------------
  {
    "aktersnurra/no-clown-fiesta.nvim",
    lazy=false,
    priority=false,
    config=function()
      vim.cmd([[colorscheme no-clown-fiesta]])
    end,
  },
  
  ---------
  -- LSP --
  ---------
  {
    "williamboman/mason.nvim",
    lazy=false,
  },
  

  -------------
  -- PLUGINS --
  -------------

  -- Startuptime profiler
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Indent blankline
  { 
    "lukas-reineke/indent-blankline.nvim", 
    lazy=false,
  },

  -- Dev icons
  { 
    "nvim-tree/nvim-web-devicons", 
    lazy = true,
  },

  -- Nicer UI
  { 
    "stevearc/dressing.nvim", 
    event = "VeryLazy",
  },

  -- Nicer notifications
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },


}
