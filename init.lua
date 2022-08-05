-- Author: Matthew Meeker
-- Endgame neovim configuration.

local core_modules = {

  -- Core configuration, setting keybinds
  "core/init",

  -- Plugin Configurations
  "pack/init",

  -- Miscellaneous utilities
  "utils/init",

}

for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
      return err
    end
end
