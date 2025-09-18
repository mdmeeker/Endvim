return {
    -- Color picker and highlighter
    {
      "uga-rosa/ccc.nvim",
      cmd = {
        "CccPick",
        "CccHighlighterEnable", 
        "CccHighlighterToggle",
      },
      config = function()
        require("ccc").setup({
          bar_char = "■",
          point_char = "◇",
          win_opts = {
            border = "solid",
            style = "minimal",
            col = 1,
            row = 1,
            relative = "cursor",
          },
        })
      end,
    },
  }