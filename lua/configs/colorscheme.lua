-- Author: Matthew Meeker

-- Using nightfox
-- Default options
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,    -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,   -- Non focused panes set to alternative background
    styles = {              -- Style to be applied to different syntax groups
      comments = "italic",    -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "bold",
      keywords = "bold",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "italic",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      aerial = true,
      cmp = true,
      lsp_saga = true,
      lsp_trouble = true,
      nvimtree = {
        enable = true,
        background = true,
      },
      gitsigns = true,
      treesitter = true,
    },
  }
})

local status_ok, _ = pcall(vim.cmd, "colorscheme oxocarbon")
if not status_ok then
  return
end
