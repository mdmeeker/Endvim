return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local function diagnostics()
                local diag = vim.diagnostic.get(0)
                if #diag == 0 then return '' end

                local error_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                local warn_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                local info_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                local hint_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })

                local parts = {}
                if error_count > 0 then table.insert(parts, " " .. error_count) end
                if warn_count > 0 then table.insert(parts, " " .. warn_count) end
                if info_count > 0 then table.insert(parts, " " .. info_count) end
                if hint_count > 0 then table.insert(parts, " " .. hint_count) end

                return table.concat(parts, " ")
            end

            local function lsp_status()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then return "" end
                return " LSP: " .. table.concat(vim.tbl_map(function(c) return c.name end, clients), ", ")
            end

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "│", right = "│" },
                    section_separators = { left = "", right = "" },
                    globalstatus = true, -- Single statusline for all windows (nyoom-like efficiency)
                },
                sections = {
                    lualine_a = {
                        { "mode", icons_enabled = true, icon = "" }, -- Nyoom-style mode with icon
                    },
                    lualine_b = {
                        { "branch", icon = "" }, -- Git branch with icon
                        diagnostics,
                    },
                    lualine_c = { { "filename", path = 1 } }, -- Relative path for filename
                    lualine_x = {
                        lsp_status, -- LSP clients (nyoom often shows this)
                        "searchcount",
                        "location",
                    },
                    lualine_y = { "filetype" },
                    lualine_z = { "progress" },
                },
            })
        end,
    },
}