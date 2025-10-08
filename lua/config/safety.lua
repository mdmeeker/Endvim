-- Safety and recovery configuration
-------------------------------------------------------------------------

local M = {}

-- Auto-save configuration
M.setup_autosave = function()
    local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })
    
    vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
        group = autosave_group,
        pattern = "*",
        callback = function()
            if vim.bo.modified and not vim.bo.readonly then
                vim.cmd("silent! write")
            end
        end,
    })
end

-- Recovery system
M.setup_recovery = function()
    local recovery_group = vim.api.nvim_create_augroup("Recovery", { clear = true })
    
    vim.api.nvim_create_autocmd("VimEnter", {
        group = recovery_group,
        pattern = "*",
        callback = function()
            local swap_file = vim.fn.findfile(".", vim.fn.expand("%:p:h"), "swapfile")
            if swap_file ~= "" then
                vim.notify("Swap file found: " .. swap_file, vim.log.levels.WARN)
            end
        end,
    })
end

-- Optional performance monitoring (disabled by default)
M.setup_performance_monitoring = function()
    -- Only enable if debug mode is active
    local logging = require("config.logging")
    if logging.get_level() ~= "DEBUG" then
        return
    end
    
    local insert_start_time = 0
    
    vim.api.nvim_create_autocmd("InsertEnter", {
        pattern = "*",
        callback = function()
            insert_start_time = vim.loop.hrtime()
        end,
    })
    
    vim.api.nvim_create_autocmd("InsertLeave", {
        pattern = "*",
        callback = function()
            if insert_start_time > 0 then
                local duration = (vim.loop.hrtime() - insert_start_time) / 1000000
                if duration > 100 then
                    logging.warn("Slow insert mode exit: %.2fms in %s", duration, vim.bo.filetype)
                end
                insert_start_time = 0
            end
        end,
    })
end

-- Initialize safety features
M.setup = function()
    M.setup_autosave()
    M.setup_recovery()
    -- Only enable performance monitoring in debug mode
    M.setup_performance_monitoring()
end

return M