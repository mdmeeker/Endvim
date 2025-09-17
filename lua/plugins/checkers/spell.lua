-- Enable spell checking
vim.opt.spell = true
vim.opt.spelling = { "en_us" }
vim.opt.spelloptions = { "camel", "noplainbuffer" }

-- Append custom spellfile
local current_spellfile = vim.opt.spellfile:get()
if type(current_spellfile) == "table" then
    table.insert(current_spellfile, vim.fn.stdpath("config") .. "/spell/en.utf-8.add")
    vim.opt.spellfile = current_spellfile
else
    vim.opt.spellfile = {
        current_spellfile,
        vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
    }
end
