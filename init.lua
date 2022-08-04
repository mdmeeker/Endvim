-- Author: Matthew Meeker

local core_modules = {

  -- Core Settings
  "core/plugins",
  "core/keymaps",
  "core/options",

  -- visual
  "configs/colorscheme",
  "configs/colorizer",

  -- Plugin Configurations
  "configs/impatient",
  "configs/alpha-nvim",
  "configs/nvim-tree",
  "configs/treesitter",

  "configs/LSP_configs/completion",
  "configs/LSP_configs/aerial",
  "configs/LSP_configs/trouble",

  -- functionalities
  "configs/gitsigns",
  "configs/commentary",
  "configs/smooth-scrl",
  "configs/toggleterm",
  "configs/lualine",
  "configs/incline",
  "configs/telescope",

  ---- Other Utilities
  "utils/vstuff",

}

for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
      return err
    end
end
