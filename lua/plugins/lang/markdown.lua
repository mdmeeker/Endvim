return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            file_types = { "markdown", "Avante" },
            anti_conceal = { enabled = true },
        },
        ft = { "markdown", "Avante" },
        config = function(_, opts)
            require("render-markdown").setup(opts)
            vim.api.nvim_create_autocmd(
                "FileType",
                {
                    pattern = "Avante",
                    callback = function(ev)
                        vim.treesitter.start(ev.buf, "markdown")
                        vim.opt_local.conceallevel = 3
                    end
                }
            )

        end
    },
}