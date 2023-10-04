-- Author: Matthew Meeker

local modules = {
  "core/plugins",
  "core/settings"
}



for _, module in ipairs(modules) do
  local ok, err = pcall(require, module)
  if not ok then
    return err
  end
end