-- Define highlight groups for markdown headings with progressive contrast
vim.api.nvim_set_hl(0, "MDHeading1", { fg = "#d8eaf5", bg = "#1c1f26", bold = true })  -- Brightest foreground on the lightest background
vim.api.nvim_set_hl(0, "MDHeading2", { fg = "#c6dce5", bg = "#323742", bold = true })  -- Slightly dimmer foreground on a darker background
vim.api.nvim_set_hl(0, "MDHeading3", { fg = "#b4c9d5", bg = "#1c1f26", bold = false }) -- Soft Grayish Blue on a dark slate
vim.api.nvim_set_hl(0, "MDHeading4", { fg = "#a2b8c8", bg = "#1c1f26", bold = false }) -- Muted Blue on a darker gray
vim.api.nvim_set_hl(0, "MDHeading5", { fg = "#8fa3b3", bg = "#1c1f26", bold = false }) -- Muted Steel Blue on a deeper slate
vim.api.nvim_set_hl(0, "MDHeading6", { fg = "#7d8ea0", bg = "#1c1f26", bold = false }) -- Low-Saturation Slate on the darkest gray
return {
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup({
        replace_engine = {
          ["sed"] = {
            cmd = "sed",
            args = {
              "-i",
              "",
              "-E",
            },
          },
        },
      })
    end
  },
  {
    "mpas/marp-nvim",
    config = function()
      require("marp").setup({
        port = 8080,
        wait_for_response_timeout = 30,
        wait_for_response_delay = 1,
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        transparent_background = true,
        color_overrides = {
          mocha = {
            base = "#1c1c1e",
            mantle = "#1c1c1e",
            crust = "#1c1c1e",
          }
        },
      }
    end
  },
  -- { "rebelot/kanagawa.nvim", name = "kanagawa.nvim", priority = 1000 },
  { "folke/which-key.nvim", event = "VeryLazy" },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    opts = {
      render_modes = { 'n', 'c', 't', 'v', 'i', 'v', 'V', 'x' },
      heading = {
        icons = { ' ', ' ', ' ', ' ', ' ', ' ' },
        border = { true, false, false, false, false, false },
        backgrounds = {
          "MDHeading1", "MDHeading2", "MDHeading3", "MDHeading4", "MDHeading5", "MDHeading6"
        },
      },
      code = {
        style = 'normal',
        sign = false,
        left_margin = 2,
        left_pad = 2,
      },
      paragraph = {
        left_margin = 2,
      },
      indent = {
        enabled = true,
      }
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        sections = {
          lualine_a = { 'branch' },
          lualine_b = { 'diff', 'diagnostics' },
          -- lualine_c = { 'filename' },
          lualine_c = { 'buffers' },
          lualine_x = { 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        }
      }
    end,
  },
  {
    'folke/zen-mode.nvim',
    opts = { window = { width = 180, backdrop = 0 } },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require('notify').setup({
        background_colour = "#1c1c1e",
        stages = "fade",
        timeout = 3000,
        max_width = 80,
        max_height = 10,
        minimum_width = 20,
        minimum_height = 5,
      })
      require("noice").setup({
        lsp = {
          signature = { enable = false, auto_open = false },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = {
            views = {
              cmdline_popup = {
                position = { row = "50%", col = "50%" },
                size = { min_width = 60, width = "auto", height = "auto" },
              }
            }
          },
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = "markdown",
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre " .. vim.fn.expand("~") .. "/notes/my-vault/*.md",
    --   "BufNewFile " .. vim.fn.expand("~") .. "/notes/my-vault/*.md",
    -- },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter",
    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = vim.fn.expand("~") .. "/notes",
        },
      },
      templates = {
        folder = vim.fn.expand("~") .. "/obsidian-template/templates",
        date_format = "%m-%d-%Y",
        time_format = "%H:%M",
      },
      daily_notes = {
        folder = "notes/dailies",
        date_format = "%m-%d-%Y",
        template = "daily/Daily Note.md",
      },
      ui = { enable = true },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        }
      },
      new_notes_location = "~/notes"
    },
  },
}
