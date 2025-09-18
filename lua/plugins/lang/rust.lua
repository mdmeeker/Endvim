return {
    -- Crates.nvim for Cargo.toml dependency management
    {
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      config = function()
        require("crates").setup()
      end,
    },
  
    -- Enhanced Rust development with rust-analyzer
    {
      "simrat39/rust-tools.nvim",
      ft = "rust",
      dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-lua/plenary.nvim",
        "mfussenegger/nvim-dap",
      },
      config = function()
        -- Only setup if LSP is available (mimics nyoom's module check)
        local ok, _ = pcall(require, "lspconfig")
        if ok then
          -- Copy nyoom's tools configuration exactly
          local tools = {
            server = {
              settings = {
                ["rust-analyzer"] = {
                  checkOnSave = {
                    command = "clippy",
                  },
                },
              },
            },
            hover_actions = {
              border = {
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
                { " ", "FloatBorder" },
              },
            },
            crate_graph = {
              backend = "svg",
            },
          }
          
          require("rust-tools").setup({ tools = tools })
        end
      end,
    },
  }