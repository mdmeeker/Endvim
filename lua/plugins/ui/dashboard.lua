return {
    {
        "goolord/alpha-nvim",
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
    
            local fortune = require("alpha.fortune")
            dashboard.section.header.val = fortune()
            dashboard.section.header.opts.position = "center"
            dashboard.section.header.opts.hl = "Type"
    
            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
                dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
                dashboard.button("q", "  Quit", ":qa<CR>"),
            }
            dashboard.section.buttons.opts.hl = "Type"
    
            dashboard.opts.layout = {
                { type = "padding", val = 4 },
                dashboard.section.header,
                { type = "padding", val = 4 },
                dashboard.section.buttons,
            }
    
            alpha.setup(dashboard.opts)
    
            vim.cmd([[
                autocmd FileType alpha setlocal nofoldenable
            ]])
        end,
    },
}