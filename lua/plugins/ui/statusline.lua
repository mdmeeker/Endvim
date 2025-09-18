return {
    -- No plugin needed - pure Vim statusline
    {
        "folke/lazy.nvim", -- dummy plugin to trigger config
        priority = 1000,
        config = function()
            -- Mode mappings (copying nyoom's design)
            local modes = {
                ["n"] = "RW",
                ["no"] = "RO", 
                ["v"] = "**",
                ["V"] = "**",
                ["\022"] = "**", -- Visual block
                ["s"] = "S",
                ["S"] = "SL",
                ["\019"] = "SB",
                ["i"] = "**",
                ["ic"] = "**",
                ["R"] = "RA",
                ["Rv"] = "RV", 
                ["c"] = "VIEX",
                ["cv"] = "VIEX",
                ["ce"] = "EX",
                ["r"] = "r",
                ["rm"] = "r",
                ["r?"] = "r",
                ["!"] = "!",
                ["t"] = "",
            }

            -- Default functions (can be blank)
            local function get_git_status()
                return ""
            end

            local function get_lsp_diagnostic()
                return ""
            end

            local function get_filetype()
                return "%#NormalNC#" .. vim.bo.filetype
            end

            local function get_bufnr()
                return "%#Comment#" .. vim.api.nvim_get_current_buf()
            end

            -- Mode color function
            local function color()
                local mode = vim.api.nvim_get_mode().mode
                local mode_color = "%#Normal#"
                
                if mode == "n" then
                    mode_color = "%#StatusNormal#"
                elseif mode == "i" or mode == "ic" then
                    mode_color = "%#StatusInsert#"
                elseif mode == "v" or mode == "V" or mode == "\022" then
                    mode_color = "%#StatusVisual#"
                elseif mode == "R" then
                    mode_color = "%#StatusReplace#"
                elseif mode == "c" then
                    mode_color = "%#StatusCommand#"
                elseif mode == "t" then
                    mode_color = "%#StatusTerminal#"
                end
                
                return mode_color
            end

            -- File info function
            local function get_fileinfo()
                local filename = vim.fn.expand("%") == "" and " nyoom-nvim v0.6.0-dev" or vim.fn.expand("%:t")
                
                if filename ~= " nyoom-nvim " then
                    filename = " " .. filename .. " "
                end
                
                return "%#Normal#" .. filename .. "%#NormalNC#"
            end

            -- Enhanced git status (if gitsigns is available)
            local function get_git_status_enhanced()
                if vim.b.gitsigns_status_dict then
                    local branch = vim.b.gitsigns_status_dict
                    local is_head_empty = branch.head ~= ""
                    
                    if is_head_empty then
                        return string.format("(λ • #%s) ", branch.head or "")
                    end
                end
                return ""
            end

            -- Enhanced LSP diagnostics
            local function get_lsp_diagnostic_enhanced()
                if not vim.lsp then
                    return ""
                end

                local function get_severity(s)
                    return #vim.diagnostic.get(0, { severity = s })
                end

                local result = {
                    errors = get_severity(vim.diagnostic.severity.ERROR),
                    warnings = get_severity(vim.diagnostic.severity.WARN),
                    info = get_severity(vim.diagnostic.severity.INFO),
                    hints = get_severity(vim.diagnostic.severity.HINT),
                }

                return string.format(
                    " %%#StatusLineDiagnosticWarn#%s %%#StatusLineDiagnosticError#%s ",
                    result.warnings or 0,
                    result.errors or 0
                )
            end

            -- Search count function
            local function get_searchcount()
                if vim.v.hlsearch == 0 then
                    return "%#Normal# " .. vim.fn.line(".") .. ":" .. vim.fn.col(".") .. " "
                end
                
                local ok, count = pcall(vim.fn.searchcount, { recompute = true })
                if not ok or not count.current or count.total == 0 then
                    return ""
                end
                
                if count.incomplete == 1 then
                    return "?/?"
                end
                
                local too_many = string.format(">%d", count.maxcount)
                local total = count.total > count.maxcount and too_many or count.total
                
                return "%#Normal#" .. string.format(" %s matches ", total)
            end

            -- Check if gitsigns is available and override git function
            local gitsigns_ok = pcall(require, "gitsigns")
            if gitsigns_ok then
                get_git_status = get_git_status_enhanced
            end

            -- Check if LSP is available and override diagnostic function  
            if vim.lsp then
                get_lsp_diagnostic = get_lsp_diagnostic_enhanced
            end

            -- Main statusline function
            _G.Statusline = {}
            _G.Statusline.statusline = function()
                local mode = vim.api.nvim_get_mode().mode
                local mode_text = modes[mode] or mode
                
                return table.concat({
                    color(),
                    string.format(" %s ", mode_text:upper()),
                    get_fileinfo(),
                    get_git_status(),
                    get_bufnr(),
                    "%=", -- Right side
                    get_lsp_diagnostic(),
                    get_filetype(),
                    get_searchcount(),
                })
            end

            -- Setup statusline
            vim.opt.laststatus = 3  -- Global statusline
            vim.opt.cmdheight = 0   -- Hide command line when not in use
            vim.opt.statusline = "%!v:lua.Statusline.statusline()"

            -- Define highlight groups for different modes (you may want to customize these)
            vim.api.nvim_set_hl(0, "StatusNormal", { fg = "#a8a8a8", bg = "#2e2e2e", bold = true })
            vim.api.nvim_set_hl(0, "StatusInsert", { fg = "#000000", bg = "#a8a8a8", bold = true })
            vim.api.nvim_set_hl(0, "StatusVisual", { fg = "#000000", bg = "#878d96", bold = true })
            vim.api.nvim_set_hl(0, "StatusReplace", { fg = "#000000", bg = "#8d8d8d", bold = true })
            vim.api.nvim_set_hl(0, "StatusCommand", { fg = "#000000", bg = "#a2a9b0", bold = true })
            vim.api.nvim_set_hl(0, "StatusTerminal", { fg = "#000000", bg = "#8f8b8b", bold = true })
            vim.api.nvim_set_hl(0, "StatusLineDiagnosticWarn", { fg = "#ffcc00", bg = "NONE" })
            vim.api.nvim_set_hl(0, "StatusLineDiagnosticError", { fg = "#ff6b6b", bg = "NONE" })
        end,
    },
}