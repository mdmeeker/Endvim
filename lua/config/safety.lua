-- Safety and recovery configuration
-------------------------------------------------------------------------

local M = {}

-- Auto-save configuration
M.setup_autosave = function()
    -- Create autosave group
    local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })
    
    -- Auto-save on focus lost and every 30 seconds
    vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
        group = autosave_group,
        pattern = "*",
        callback = function()
            if vim.bo.modified and not vim.bo.readonly then
                vim.cmd("silent! write")
            end
        end,
    })
    
    -- Periodic auto-save
    vim.api.nvim_create_autocmd("CursorHold", {
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
    -- Create recovery group
    local recovery_group = vim.api.nvim_create_augroup("Recovery", { clear = true })
    
    -- Check for swap files on startup
    vim.api.nvim_create_autocmd("VimEnter", {
        group = recovery_group,
        pattern = "*",
        callback = function()
            local swap_file = vim.fn.findfile(".", vim.fn.expand("%:p:h"), "swapfile")
            if swap_file ~= "" then
                vim.notify("Swap file found: " .. swap_file, vim.log.levels.WARN)
                vim.cmd("echohl WarningMsg")
                vim.cmd("echo 'Swap file found. Use :recover to recover changes.'")
                vim.cmd("echohl None")
            end
        end,
    })
end

-- Performance monitoring
M.setup_performance_monitoring = function()
    local logging = require("config.logging")
    
    -- Monitor insert mode performance
    local insert_start_time = 0
    vim.api.nvim_create_autocmd("InsertEnter", {
        pattern = "*",
        callback = function()
            insert_start_time = vim.loop.hrtime()
            logging.debug("Entered insert mode in %s", vim.bo.filetype)
        end,
    })
    
    vim.api.nvim_create_autocmd("InsertLeave", {
        pattern = "*",
        callback = function()
            if insert_start_time > 0 then
                local duration = (vim.loop.hrtime() - insert_start_time) / 1000000 -- Convert to ms
                if duration > 100 then -- Log if insert mode took more than 100ms
                    logging.warn("Slow insert mode exit: %.2fms in %s", duration, vim.bo.filetype)
                end
                insert_start_time = 0
            end
        end,
    })
    
    -- Monitor command line performance
    local cmdline_start_time = 0
    vim.api.nvim_create_autocmd("CmdlineEnter", {
        pattern = "*",
        callback = function()
            cmdline_start_time = vim.loop.hrtime()
        end,
    })
    
    vim.api.nvim_create_autocmd("CmdlineLeave", {
        pattern = "*",
        callback = function()
            if cmdline_start_time > 0 then
                local duration = (vim.loop.hrtime() - cmdline_start_time) / 1000000
                if duration > 500 then -- Log if command line took more than 500ms
                    logging.warn("Slow command line: %.2fms in %s", duration, vim.bo.filetype)
                end
                cmdline_start_time = 0
            end
        end,
    })
end

-- Initialize all safety features
M.setup = function()
    M.setup_autosave()
    M.setup_recovery()
    M.setup_performance_monitoring()
end

return M