vim.opt.linebreak = true
vim.opt.breakindent = true

-- File-specific word wrapping
local word_wrap_group = vim.api.nvim_create_augroup("word-wrap", { clear = true })
local wrap_filetypes = { "*.md", "*.txt", "*.norg", "*.org", "*.tex", "*.rst" }
for _, pattern in ipairs(wrap_filetypes) do
    vim.api.nvim_create_autocmd("BufWinEnter", {
        group = word_wrap_group,
        pattern = pattern,
        callback = function()
            vim.opt_local.wrap = true
        end,
    })
end