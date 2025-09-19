local function bufexists(...)
    return vim.fn.bufexists(...) == 1
end

-- Open file on last position
local open_file_group = vim.api.nvim_create_augroup("OpenFileOnLastPosition", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = open_file_group,
    pattern = "*",
    callback = function()
        vim.cmd('silent! normal! g`"zv')
    end,
})

-- Resize splits on window resize
local resize_group = vim.api.nvim_create_augroup("ResizeSplitsOnResize", { clear = true })
vim.api.nvim_create_autocmd("VimResized", {
    group = resize_group,
    pattern = "*",
    callback = function()
        vim.cmd.wincmd("=")
    end
})

-- Read file on disk change
local read_file_group = vim.api.nvim_create_augroup("ReadFileOnDiskChange", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    group = read_file_group,
    pattern = "*",
    callback = function()
        if vim.fn.mode() ~= "c" and not bufexists("[Command Line]") then
            vim.cmd.checktime()
        end
    end
})

-- Reload buffer on disk change
vim.api.nvim_create_autocmd("FileChangedShellPost", {
    group = read_file_group,
    pattern = "*",
    callback = function()
        vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO)
    end
})

-- Properly open files with GF
local gf_group = vim.api.nvim_create_augroup("ProperlyOpenFilesWithGF", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = gf_group,
    pattern = { "lua" },
    callback = function()
        vim.opt_local.path:prepend(vim.fn.stdpath("config") .. "/lua")
        vim.opt_local.suffixesadd:prepend("/init.lua")
        vim.opt_local.suffixesadd:prepend(".lua")
        vim.opt_local.includeexpr = "tr(v:fname,',.','/')"
    end
})


return {
    { import = "plugins.core.animate" },
    { import = "plugins.core.colorscheme" },
    { import = "plugins.core.lsp" },
    { import = "plugins.core.mini" },
    { import = "plugins.core.smartparens" },
}