if vim.g.vscode then
  return {}
end


return {
  -- {
  --   "benfowler/telescope-luasnip.nvim",
  --   dependencies = {"L3MON4D3/LuaSnip", }
  -- },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    'ThePrimeagen/git-worktree.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    'nvim-telescope/telescope-symbols.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', "benfowler/telescope-luasnip.nvim" },
    config = function()
      require('telescope').setup({
        defaults = {
          sorting_strategy = 'ascending',
          layout_config = { prompt_position = 'top' },
        },
        pickers = {
          live_grep = {
            only_sort_text = true,
          },
          buffers = {
            previewer = false,
            initial_mode = "normal",
            layout_config = { width = 0.5, height = 0.5, mirror = true },
          },
          grep_string = { only_sort_text = true },
        },
      })
      require('telescope').load_extension('luasnip')
      require('telescope').load_extension('git_worktree')
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   }
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local nvim_tree_w = 0.5
      local nvim_tree_h = 0.8
      -- local nvim_tree_min_w = 30
      require('nvim-tree').setup({
        sort = {
          sorter = "filetype",
        },
        actions = { open_file = { window_picker = { enable = false } } },
        disable_netrw = true,
        hijack_netrw = true,
        respect_buf_cwd = true,
        sync_root_with_cwd = true,
        renderer = {
          icons = {
            git_placement = "signcolumn",
            modified_placement = "after",
            hidden_placement = "after",
            diagnostics_placement = "signcolumn",
            bookmarks_placement = "signcolumn",
          }
        },
        view = {
          float = {
            enable = true,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * nvim_tree_w
              local window_h = screen_h * nvim_tree_h
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2)
                  - vim.opt.cmdheight:get()
              return {
                border = "rounded",
                relative = "editor",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
          width = function()
            return math.floor(vim.opt.columns:get() * nvim_tree_w)
          end,
        },
      })
    end
  },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim"
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function()
  --     require("neo-tree").setup({
  --       event_handlers = {
  --         {
  --           event = "file_opened",
  --           handler = function(file_path)
  --             require("neo-tree.command").execute({ action = "close" })
  --           end,
  --         },
  --       },
  --       window = { position = "right" },
  --     })
  --   end,
  -- },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {
      search = {
        multi_window = false,
        forward = true,
        wrap = false,
      },
      jump = {
        nohlsearch = true,
        autojump = true,
      },
      label = {
        uppercase = false,
      },
      modes = {
        char = {
          autohide = true,
          highlight = { backdrop = false },
        },
      },
      prompt = {
        win_config = {
          width = 1, -- when <=1 it's a percentage of the editor width
          height = 1,
          row = -1,  -- when negative it's an offset from the bottom
          col = 0,   -- when negative it's an offset from the right
        },
      },
    },
    -- stylua: ignore
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({ settings = { save_on_toggle = true } })
    end,
  }
}
