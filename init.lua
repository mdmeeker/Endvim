
-- LAZY NVIM BOOTSTRAP
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

-- Base keymaps, not dependent on plugins. Creates safer start in case one of the later require's fails.
require("base_keymaps")

-- Now, include settings and configurations
require("settings")

-- Lazy.nvim
require("lazy").setup("plugin_install")




