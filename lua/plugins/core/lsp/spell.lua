-- Enable spell checking only for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "gitcommit", "org", "tex" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = { "en_us" }
        vim.opt_local.spelloptions = {
            "camel",
            "noplainbuffer",
            "nospellcap",
        }
        vim.opt_local.spellsuggest = "best,9"

        -- For LaTeX, rely on vimtex's syntax groups (NoSpell on commands/math)
        -- No extra :syntax rules here; vimtex already marks commands/math as @NoSpell
    end,
})

-- Append custom spellfile
local current_spellfile = vim.opt.spellfile:get()
if type(current_spellfile) == "table" then
    table.insert(current_spellfile, vim.fn.stdpath("config") .. "/spell/en.utf-8.add")
    vim.opt.spellfile = current_spellfile
else
    vim.opt.spellfile = {
        current_spellfile,
        vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
    }
end

return {}