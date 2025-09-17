return {
  -- Enhanced diagnostic display with lsp_lines
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
    event = "LspAttach",
    keys = {
      {
        "<leader>ul",
        function()
          require("lsp_lines").toggle()
        end,
        desc = "Toggle lsp_lines",
      },
    },
  },

  -- Modern none-ls (null-ls replacement) setup
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Copy nyoom's diagnostic configuration
      vim.diagnostic.config({
        underline = { severity = { min = vim.diagnostic.severity.INFO } },
        signs = { severity = { min = vim.diagnostic.severity.HINT } },
        virtual_text = false,
        float = {
          show_header = false,
          source = true,
        },
        update_in_insert = false,
        severity_sort = true,
      })

      -- Define diagnostic signs (you'll need to define these icons)
      local signs = {
        Error = "󰅚",  -- or your preferred error icon
        Warn = "󰀪",   -- or your preferred warn icon  
        Info = "󰋽",   -- or your preferred info icon
        Hint = "󰌶",   -- or your preferred hint icon
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
      end

      -- Set up keybindings (copying nyoom's bindings)
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostics at line" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostics" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostics" })

      -- Set up none-ls
      local null_ls = require("null-ls")
      local sources = {}

      -- Formatters (copying nyoom's conditional logic)
      -- C/C++
      table.insert(sources, null_ls.builtins.formatting.clang_format)
      
      -- Lua
      table.insert(sources, null_ls.builtins.formatting.stylua)
      
      -- Python
      table.insert(sources, null_ls.builtins.formatting.black)
      table.insert(sources, null_ls.builtins.formatting.isort)
      
      -- Shell
      table.insert(sources, null_ls.builtins.formatting.shfmt)
      
      -- Markdown
      table.insert(sources, null_ls.builtins.formatting.markdownlint)
      
      -- Rust
      table.insert(sources, null_ls.builtins.formatting.rustfmt)
      
      -- Zig
      table.insert(sources, null_ls.builtins.formatting.zigfmt)

      -- Diagnostics (copying from nyoom)
      table.insert(sources, null_ls.builtins.diagnostics.selene) -- Lua

      -- Code actions
      table.insert(sources, null_ls.builtins.code_actions.gitsigns)

      null_ls.setup({
        sources = sources,
        -- Copy nyoom's diagnostic format
        diagnostics_format = "[#{c}] #{m} (#{s})",
        debug = false, -- Set to true if you want debug output like nyoom
      })
    end,
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Keep conform.nvim separate for modern 2025 practice
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        lua = { "stylua" },
        python = { "black", "isort" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        markdown = { "markdownlint" },
        zig = { "zigfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ lsp_format = "fallback" })
        end,
        desc = "Format buffer",
      },
    },
  },

}