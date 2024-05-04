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

require("core/options")
require("core/keymaps")
require("core/plugins")
require("core/colorscheme")



local core_modules = {
    -- Plugin Configurations
    "configs/lualine",

    "configs/treesitter",

    "configs/mason",

    "configs/neoscroll",

    "configs/alpha-nvim",

    "configs/toggleterm",

    "configs/comment"
    -- "configs/nvim-tree",
  
    -- "configs/LSP_configs/completion",
    -- "configs/LSP_configs/aerial",
  
    -- functionalities
    -- "configs/commentary",
    -- "configs/incline",
    -- "configs/telescope",
}
  

  
  for _, module in ipairs(core_modules) do
  --    local ok, err = pcall(require, module)
  --     if not ok then
  --       return err
  --     end

    require(module)
  end
