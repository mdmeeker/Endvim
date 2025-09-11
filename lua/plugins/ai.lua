return {
    {
        "yetone/avante.nvim",
        build = "make",
        event = "VeryLazy",
        version = false,

        --@module 'avante'
        --@type avante.Config
        opts = {
            instructions_file = "~/.config/nvim/instructions.md",
            providers = {
                claude = {
                    endpoint = "https://api.anthropic.com",
                    model = "claude-sonnet-4-20250514",
                    timeout = 30000,
                    disable_tools = true,
                    extra_request_body = {
                        temperature = 0.7,
                        max_tokens = 20480,
                    },
                },
                grok = {
                    endpoint = "https://api.x.ai/v1/chat/completions",
                    model = "grok-4",

                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-tree/nvim-web-devicons",
            "stevearc/dressing.nvim",
            {
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                    }
                }
            },
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
        },
        -- config = function()
        --     http = {
        --       adapters = {
        --         grok = function()
        --           return require("codecompanion.adapters").extend("openai", {
        --             name = "grok",
        --             url = "https://api.x.ai/v1/chat/completions",
        --             env = { api_key = "XAI_API_KEY" },
        --             schema = {
        --               model = { default = "grok-4" },
        --               max_tokens = { default = 4096 },
        --             },
        --           })
        --         end,
        --       },
        --     },
        --     strategies = {
        --       chat = {
        --         adapter = "grok",
        --       },
        --     },
        --   })
        -- end,
    }
}