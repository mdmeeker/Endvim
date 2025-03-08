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


-- NOTE: must be loaded before
--       VimTex itself apparently
require("configs/vimtex")

require("core/options")
require("core/keymaps")
require("core/plugins")
require("core/colorscheme")



local core_modules = {
    -- Plugin Configurations
    "configs/completion",
    "configs/status_line",

    "configs/treesitter",

    "configs/mason",

    "configs/neoscroll",

    "configs/alpha-nvim",

    "configs/toggleterm",

    "configs/nvimtree",

    "configs/comment",

    "utils/vstuff"
  
}
  

  
  for _, module in ipairs(core_modules) do
  --    local ok, err = pcall(require, module)
  --     if not ok then
  --       return err
  --     end

    require(module)
  end
