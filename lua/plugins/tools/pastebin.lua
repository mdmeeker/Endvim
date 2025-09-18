return {
    -- Paperplanes.nvim for easy pastebin functionality
    {
      "rktjmp/paperplanes.nvim",
      cmd = "PP",
      config = function()
        require("paperplanes").setup({
          provider = "paste.rs",
        })
      end,
    },
  }