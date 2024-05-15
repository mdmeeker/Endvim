-- Author: Matthew Meeker

require("no-clown-fiesta").setup({
  transparent = false, -- Enable this to disable the bg color
  styles = {
    -- You can set any of the style values specified for `:h nvim_set_hl`
    comments = { italic = true },
    functions = { bold = true },
    keywords = {},
    lsp = { underline = true },
    match_paren = {},
    type = { bold = true },
    variables = {},
  },
})

local status_ok, _ = pcall(vim.cmd, "colorscheme no-clown-fiesta")
if not status_ok then
  return
end
