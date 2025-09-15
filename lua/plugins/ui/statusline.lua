return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        config = function()
            require("mini.statusline").setup({
                content = {
                    active = function()
                        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                        local git = MiniStatusline.section_git({ trunc_width = 75 })
                        
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
                            '%<',
                            { hl = 'MiniStatuslineFilename', strings = { filename } },
                            '%=',
                            { hl = 'MiniStatuslineDevinfo', strings = { search, location } },
                            { hl = mode_hl, strings = { fileinfo } },
                        })
                    end,
                },
                use_icons = true,
            })
        end,
    },
}