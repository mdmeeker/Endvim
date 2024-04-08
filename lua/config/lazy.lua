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


---@param opts LazyConfig
return function(opts)
    opts = vim.tbl_deep_extend("force", {
      spec = {
        { import = "plugins" },
      },
      defaults = { lazy = true },
      dev = {
        -- patterns = { "folke", "LazyVim" },
        -- fallback = jit.os:find("Windows"),
      },
      install = { },
      checker = { enabled = true },
      diff = {
        cmd = "terminal_git",
      },
      performance = {
        cache = {
          enabled = true,
          -- disable_events = {},
        },
        rtp = {
          disabled_plugins = {
            "gzip",
            -- "matchit",
            -- "matchparen",
            -- "netrwPlugin",
            "rplugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
          },
        },
      },
      ui = {
        custom_keys = {
          ["<localleader>d"] = function(plugin)
            dd(plugin)
          end,
        },
      },
      debug = false,
    }, opts or {})
    require("lazy").setup(opts)
  end