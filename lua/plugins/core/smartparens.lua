return {
    -- Simple parenthesis matching (copying nyoom's setup)
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")
            
            npairs.setup({
                disable_filetype = { "TelescopePrompt", "vim" },
                disable_in_macro = false,
                disable_in_visualblock = false,
                ignore_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
                enable_moveright = true,
                enable_afterquote = true,
                enable_check_bracket_line = true,
                enable_bracket_in_quote = true,
                break_undo = true,
                check_ts = true,
                map_cr = true,
                map_bs = true,
                map_c_h = false,
                map_c_w = false,
            })
    
            -- Add LaTeX $ pairing
            npairs.add_rules({
            Rule("$", "$", { "tex", "latex" })
                :with_move(function(opts)
                    return opts.char == "$"
                end),
            })
            
            -- Disable single quote pairing in TeX files
            npairs.get_rule("'")[1].not_filetypes = { "tex", "latex", "txt", "markdown", "org" }
        end,
    },
  
    -- Lua-based matchparen alternative
    {
        "monkoose/matchparen.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("matchparen").setup()
        end,
    },
}