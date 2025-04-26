local servers = {
  latex = vim.fn.executable('latexmk'),
  c = vim.fn.executable('clangd'),
  python = vim.fn.executable('ruff')
}

return {
  {
    "lervag/vimtex",
    cond = not vim.g.vscode and servers.latex == 1,
    init = function()
      vim.g.localleader = " "
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_skim_activate = 0
      vim.g.vimtex_format_enabled = 1
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull",
        "Overfull",
        "Tight",
        "LaTeX Font Warning",
        "Package breakurl Warning",
        "Package caption Warning: Unknown document class",
        "Package nameref Warning:",
      }
      vim.api.nvim_create_autocmd("User", {
        pattern = "VimtexEventViewReverse",
        group = au_group,
        command = "call system('osascript -e \"tell application \\\"WezTerm\\\" to revert front document\"')",
      })
    end,
    config = function()
      vim.fn['vimtex#imaps#add_map']({
        lhs = 'r',
        rhs = 'vimtex#imaps#style_math("mathrm")',
        expr = 1,
        leader = '#',
        wrapper = 'vimtex#imaps#wrap_math'
      })
      vim.fn['vimtex#imaps#add_map']({
        lhs = 'b',
        rhs = 'vimtex#imaps#style_math("mathbf")',
        expr = 1,
        leader = '#',
        wrapper = 'vimtex#imaps#wrap_math'
      })
      vim.fn['vimtex#imaps#add_map']({
        lhs = 'eq',
        rhs = '\\begin{equation}\r\r\\end{equation}',
        leader = '#',
        wrapper = 'vimtex#imaps#wrap_trivial',
      })
      vim.fn['vimtex#imaps#add_map']({
        lhs = 'aeq',
        leader = '#',
        rhs = '\\begin{equation}\r  \\begin{aligned}\r\r  \\end{aligned}\r\\end{equation}',
        wrapper = 'vimtex#imaps#wrap_trivial'
      })
      vim.fn['vimtex#imaps#add_map']({
        lhs = 'algn',
        rhs = '\\begin{align}\r\r\\end{align}',
        leader = '#',
        wrapper = 'vimtex#imaps#wrap_trivial'
      })
      vim.fn['vimtex#imaps#add_map']({
        lhs = 'frm',
        rhs = '\\begin{frame}{}\r\r\\end{frame}',
        leader = '#',
        wrapper = 'vimtex#imaps#wrap_trivial',
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "query", "javascript", "html", "cpp", "python", "latex", "bash" },
        sync_install = false,
        highlight = { enable = true, disable = { "latex" } },
        indent = { enable = true },
        tree_docs = {enable = true}
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   opts = { select_signature_key = "<C-k>" },
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end,
  -- },
  -- Installation
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("cpp", {
        s("cls", {
          t("class "), i(1, "ClassName"), t({ "", "{" }),
          t({ "", "    // member variables", "    private:" }),
          t({ "", "    protected:" }),
          t({ "", "    public:" }),
          t({ "", "    // member functions", "    private:" }),
          t({ "", "    protected:" }),
          t({ "", "    public:" }),
          t({ "", "};" }),
        })
      })

      ls.add_snippets("hpp", {
        s("cls", {
          t("class "), i(1, "ClassName"), t({ "", "{" }),
          t({ "", "    // member variables", "    private:" }),
          t({ "", "    protected:" }),
          t({ "", "    public:" }),
          t({ "", "    // member functions", "    private:" }),
          t({ "", "    protected:" }),
          t({ "", "    public:" }),
          t({ "", "};" }),
        })
      })
    end,
  },
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
      -- See `:help cmp`
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
          end
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-;>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "nvim_lsp_signature_help" },
          { name = 'render-markdown' },
          { name = 'marksman' },
          { name = 'luasnip' },
        },
        completion = { completeopt = "menu,menuone,noinsert" },
      })
    end,
  },
  { 'saadparwaiz1/cmp_luasnip' },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
      { 'nvim-telescope/telescope.nvim', cond = vim.g.vscode }
    },
    config = function()
      -- LSP install
      local mason = require("mason")
      mason.setup()
      local ensure_installed = { "lua_ls", "dockerls", "bashls", "marksman" }
      if servers.c == 1 then table.insert(ensure_installed, "clangd") end
      if servers.latex == 1 then table.insert(ensure_installed, "texlab") end
      if servers.python == 1 then table.insert(ensure_installed, "pyright") end
      require("mason-lspconfig").setup {
        ensure_installed = ensure_installed,
      }


      require("cmp_nvim_lsp").setup { sources = { { name = 'nvim_lsp' } } }
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup {
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            return
          end
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = { version = 'LuaJIT' },
            workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } }
          })
        end,
        settings = { Lua = {} }
      }
      lspconfig.bashls.setup { capabilities = capabilities }
      lspconfig.dockerls.setup { capabilities = capabilities }
      lspconfig.marksman.setup { capabilities = capabilities }
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" },
        {
          pattern = { vim.fn.expand("~/notes") .. "/**/*.md" },
          callback = function()
            vim.opt_local.conceallevel = 2
            vim.opt_local.concealcursor = "nvc"
          end
        }
      )
      if servers.c == 1 then
        lspconfig.clangd.setup {
          capabilities = capabilities,
          filetypes = { "c", "cpp", "hpp" },
          cmd = { "clangd", "--offset-encoding=utf-16", "--header-insertion=never", "--header-insertion-decorators=0" },
          on_attach = function(client, bufnr)
            -- Configure diagnostics with a custom handler
            vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
              if not result or not result.diagnostics then
                return
              end

              -- Filter diagnostics
              local filtered_diagnostics = {}
              for _, diagnostic in ipairs(result.diagnostics) do
                -- Apply filtering logic
                if not (diagnostic.message and diagnostic.message:find("Included header") and diagnostic.message:find("directly")) then
                  table.insert(filtered_diagnostics, diagnostic)
                end
              end

              -- Update diagnostics in the result
              result.diagnostics = filtered_diagnostics

              -- Pass the filtered diagnostics to the default handler
              vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
            end
          end
        }
      end
      if servers.latex == 1 then
        lspconfig.texlab.setup
        {
          capabilities = capabilities,
          settings = {
            texlab =
            {
              bibtexFormatter = "texlab",
              diagnostics = { ignoredPatterns = {
                "Underfull",
                "Overfull",
                "Tight",
                "LaTeX Font Warning",
                "Package breakurl Warning",
                "Package caption Warning: Unknown document class",
                "Package nameref Warning:",
              }, },
              build = { onSave = false },
              latexFormatter = "latexindent",
            },
          },
        }
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "tex", -- Trigger only for LaTeX files
          callback = function()
            vim.keymap.set("n", "<leader>cf", function()
              local curpos = vim.api.nvim_win_get_cursor(0) -- Save the current cursor position
              vim.cmd("silent normal! gg=G")                -- Format the entire buffer silently
              vim.api.nvim_win_set_cursor(0, curpos)        -- Restore the cursor position
              vim.cmd("normal! zz")                         -- Format the entire buffer silently
            end, { buffer = true, desc = "[F]ormat LaTeX", silent = true })
          end,
        })
      end
      if servers.python == 1 then lspconfig.pyright.setup { capabilities = capabilities } end
    end,
  },
}
