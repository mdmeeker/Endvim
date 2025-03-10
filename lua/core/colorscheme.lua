-- Colorscheme configuration

local colorscheme = "everforest"

----- CONFIGURES sainnhe/everforest
-- vim.g.everforest_background = 'dark'
-- vim.g.everforest_better_performance = 1
-- vim.g.everforest_enable_italic = 1
-- vim.g.everforest_diagnostic_text_highlight = 1
-- vim.g.everforest_diagnostic_line_highlight = 1
-- vim.g.everforest_diagnostic_virtual_text = 'colored'

local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status then
  vim.notify("Colorscheme " .. colorscheme .. " not found!")
  vim.cmd("colorscheme habamax")
  return
end 