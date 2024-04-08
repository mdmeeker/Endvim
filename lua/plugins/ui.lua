return {

  -- auto-resize windows
  {
    "anuvyklack/windows.nvim",
    enabled = false,
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    keys = { { "<leader>m", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
    config = function()
      vim.o.winwidth = 5
      vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 150 },
      })
    end,
  },
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return require("util.dashboard").status()
        end,
      })

      ---@type table<string, {updated:number, total:number, enabled: boolean}>
      local mutagen = {}

      local function mutagen_status()
        local cwd = vim.uv.cwd() or "."
        mutagen[cwd] = mutagen[cwd]
          or {
            updated = 0,
            total = 0,
            enabled = vim.fs.find("mutagen.yml", { path = cwd, upward = true })[1] ~= nil,
          }
        local now = vim.uv.now() -- timestamp in milliseconds
        if mutagen[cwd].enabled and (mutagen[cwd].updated + 10000 < now) then
          local sessions = vim.tbl_filter(function(line)
            return line:match("^Name: %S*")
          end, vim.fn.systemlist("mutagen project list"))
          mutagen[cwd].updated = now
          mutagen[cwd].total = #sessions
          if #sessions == 0 then
            vim.notify("Mutagen is not running", vim.log.levels.ERROR, { title = "Mutagen" })
          end
        end
        return mutagen[cwd]
      end

      local error_color = LazyVim.ui.fg("DiagnosticError")
      local ok_color = LazyVim.ui.fg("DiagnosticInfo")
      table.insert(opts.sections.lualine_x, {
        cond = function()
          return mutagen_status().enabled
        end,
        color = function()
          return mutagen_status().total == 0 and error_color or ok_color
        end,
        function()
          local total = mutagen_status().total
          return (total == 0 and "󰋘 " or "󰋙 ") .. total
        end,
      })

      -- local count = 0
      -- table.insert(opts.sections.lualine_x, {
      --   function()
      --     count = count + 1
      --     return tostring(count)
      --   end,
      -- })
    end,
  },

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
}
