-- Enable spell checking only for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "gitcommit", "org", "tex" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = { "en_us" }
        -- Improved spell options for better LaTeX support
        vim.opt_local.spelloptions = { 
            "camel",           -- Allow camelCase words
            "noplainbuffer",   -- Don't check plain text buffers
            "nospellcap"       -- Don't require capitalization
        }
        -- Reduce spell checking frequency and suggestions
        vim.opt_local.spellsuggest = "best,9"  -- Only show best 9 suggestions
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
        vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
    }
end

return {}