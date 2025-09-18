return {
  -- Main Neorg plugin
  {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      })
    end,
  },

  -- Math preview for Neorg and LaTeX
  {
    "jbyuki/nabla.nvim",
    ft = { "tex", "norg" },
    config = function()
      local nabla = require("nabla")
      
      -- Keybindings (copying nyoom's mappings)
      vim.keymap.set("n", "<leader>ov", nabla.enable_virt, { desc = "Nabla Preview" })
      vim.keymap.set("n", "<leader>op", function()
        nabla.popup({ border = "solid" })
      end, { desc = "Nabla Popup" })
    end,
  },
}