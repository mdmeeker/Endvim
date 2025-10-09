local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

vim.cmd([[
  syntax enable
  filetype plugin indent on
]])

require("config.options")
require("config.keymaps")
require("config.logging")
require("config.safety")
require("config.debug")

local safety = require("config.safety")
safety.setup()

local debug = require("config.debug")
debug.setup_commands()

-- Load plugins with Lazy
require("lazy").setup(
    "plugins",
    {
        performance = {
            rtp = {
                disabled_plugins = {
                    "netrwPlugin"
                }
            }
        }
    }
)