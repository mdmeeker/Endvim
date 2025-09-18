return {
    -- Jupyter notebook integration for Neovim
    {
      "dccsillag/magma-nvim",
      build = ":UpdateRemotePlugins",
      cmd = "MagmaInit",
      config = function()
        -- Optional: Configure magma settings
        vim.g.magma_automatically_open_output = false
        vim.g.magma_image_provider = "ueberzug"
      end,
    },
  }