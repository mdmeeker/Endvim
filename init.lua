-- Author: Matthew Meeker

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local core_modules = {

    -- Core Settings
    "core/plugins",
    "core/keymaps",
    "core/options",
  
    -- visual
    "configs/colorscheme",
    "configs/colorizer",
  
    -- Plugin Configurations
    "configs/alpha-nvim",
    "configs/nvim-tree",
    "configs/treesitter",
  
    "configs/LSP_configs/completion",
    "configs/LSP_configs/aerial",
    "configs/LSP_configs/trouble",
  
    -- functionalities
    "configs/commentary",
    "configs/smooth-scrl",
    "configs/toggleterm",
    "configs/lualine",
    "configs/incline",
    "configs/telescope",
  
  }
  
  for _, module in ipairs(core_modules) do
      local ok, err = pcall(require, module)
      if not ok then
        return err
      end
  end
