local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local fortune = require("alpha.fortune")

-- Custom header
dashboard.section.header.val = {
    [[               ,@@@@@@@,                ]],
    [[       ,,,.   ,@@@@@@/@@,  .oo8888o.    ]],
    [[    ,&%%&%&&%,@@@@@/@@@@@@,8888\\88/8o  ]],
    [[   ,%&\\%&&%&&%,@@@\\@@@/@@@88\\88888/88' ]],
    [[   %&&%&%&/%&&%@@\\@@/ /@@@88888\\88888' ]],
    [[   %&&%/ %&%%&&@@\\ V /@@' `88\\8 `/88'  ]],
    [[   `&%\\ ` /%&'    |.|        \\ '|8'    ]],
    [[       |o|        | |         | |               ]],
    [[       |.|        | |         | |      ]],
    [[    \\\\/ ._\\//_/__/  ,\\_//__\\\\/.  \\_//__/_]],
}

-- Menu items
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}

-- See alphaquotes.lua for the list of quotes; randomly selected.
local fortune_options = {
    quotes = require("plugins.alphaquotes"),
}
dashboard.section.footer.val = fortune(fortune_options)
dashboard.section.footer.opts.hl = "AlphaFooter"


-- Layout specification
dashboard.config.layout = {
    { type = "padding", val = 2 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 2 },
    dashboard.section.footer,
}


alpha.setup(dashboard.opts)

-- Automatically open alpha when no files are specified
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
      require("alpha").start()
    end
  end,
}) 