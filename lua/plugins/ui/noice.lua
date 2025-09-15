return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("notify").setup({
                background_colour = "#000000", -- NOTE: For transparent background w/ wezterm.
            })


            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    }
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = true,
                    lsp_doc_border = true,
                },
                views = {
                    cmdline_popup = {
                        size = {
                            width = "60%",
                            height = "auto",
                        },
                        border = { style = "rounded" },
                        win_options = {
                            winhighlight = {
                                Normal = "NormalFloat",
                                FloatBorder = "FloatBorder",
                            },
                        },
                    },
                    notify = {
                        border = { style = "rounded" }
                    },
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            kind = "",
                            any = {
                                { find = "%d+ fewer lines" },
                                { find = "%d+ more lines" },
                                { find = "%d+ lines yanked" },
                                { find = "%d+ lines changed" },
                            },
                        },
                        opts = { skip = true },
                    },
                },
                require("telescope").load_extension("noice")
            })
        end
    },
}