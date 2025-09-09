return {
    {
        "nvim-mini/mini.nvim",
        version = false,

        config = function()
            require("mini.animate").setup({
                cursor = { 
                    enable = false
                },
            })
            -- require("mini.icons").setup()

            require("mini.surround").setup()

            require("mini.files").setup({
                options = {
                    use_as_default_explorer = true,
                    permanent_delete = true,
                    permanent_create = true,
                },
                windows = {
                    preview = true,
                    width_focus = 50,
                    width_preview = 50,
                    width_nofocus = 30,
                },
                mappings = {
                    go_in = "L",
                    go_out = "H",
                    show_help = "g?",
                },
            })
            require("mini.diff").setup({
                view = {
                    style = "sign",
                    signs = {
                        add = '│',
                        change = '│',
                        delete = '│',
                    }
                }
            })
            require("mini.git").setup({
                auto_open = true,
            })


            -- Mini statusline
            require("mini.statusline").setup({
                content = {
                    active = function()
                        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                        local git = MiniStatusline.section_git({ trunc_width = 75 })
                        
                        -- Custom diagnostics with colors
                        local diagnostics = function()
                            local diag = vim.diagnostic.get(0, { severity_limit = vim.diagnostic.severity.HINT })
                            if #diag == 0 then return '' end
                            
                            local error_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                            local warn_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                            local info_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                            local hint_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                            
                            local parts = {}
                            if error_count > 0 then
                                table.insert(parts, '%#DiagnosticError#● ' .. error_count .. '%*')
                            end
                            if warn_count > 0 then
                                table.insert(parts, '%#DiagnosticWarn#● ' .. warn_count .. '%*')
                            end
                            if info_count > 0 then
                                table.insert(parts, '%#DiagnosticInfo#● ' .. info_count .. '%*')
                            end
                            if hint_count > 0 then
                                table.insert(parts, '%#DiagnosticHint#● ' .. hint_count .. '%*')
                            end
                            
                            return table.concat(parts, ' ')
                        end
                        
                        local filename = MiniStatusline.section_filename({ trunc_width = 140 })
                        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
                        local location = MiniStatusline.section_location({ trunc_width = 75 })

                        return MiniStatusline.combine_groups({
                            { hl = mode_hl, strings = { mode } },
                            { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics() } },
                            '%<', -- Mark general truncate point
                            { hl = 'MiniStatuslineFilename', strings = { filename } },
                            '%=', -- End left alignment
                            { hl = 'MiniStatuslineDevinfo', strings = { search, location } },
                            { hl = mode_hl, strings = { fileinfo } },
                        })
                    end,
                },
                use_icons = true,
            })

            require("mini.comment").setup()
            require("mini.pairs").setup()

            require("mini.tabline").setup(
                {
                    tabpage_section = "left",
                    show_icons = true,
                }
            )
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
        cmd = "Neogit",
        config = function()
            require("neogit").setup({
                integrations = { diffview = true },
                signs = {
                    section = { ">", "v" },
                    item = { ">", "v" },
                    hunk = { "", "" },
                }
            })
        end
    }
}