return {
    { "williamboman/mason.nvim", opts = {} },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
        config = function()
        local lspconfig = require("lspconfig")
        lspconfig.pyright.setup({ settings = { python = { pythonPath = vim.fn.exepath("uv") .. " run python" } } })
        for _, server in ipairs({ "clangd", "julials", "texlab" }) do
            lspconfig[server].setup({})
        end
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip" },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
            snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }, { name = "path" }, { name = "avante" },
            }),
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = { 
            ensure_installed = { "cpp", "python", "julia", "latex", "typst", "org" },
            highlight = { enable = true, additional_vim_regex_highlighting = { "org" } },
            fold = { enable = true }
        },
    },
}