-- Debugging utilities
-------------------------------------------------------------------------

local M = {}

-- Debug commands
M.setup_commands = function()
    local logging = require("config.logging")
    
    -- Command to view logs
    vim.api.nvim_create_user_command("ViewLogs", function()
        local log_file = logging.get_log_file()
        vim.cmd("split " .. log_file)
    end, { desc = "View Neovim debug logs" })
    
    -- Command to clear logs
    vim.api.nvim_create_user_command("ClearLogs", function()
        logging.clear()
        vim.notify("Logs cleared", vim.log.levels.INFO)
    end, { desc = "Clear debug logs" })
    
    -- Command to set log level
    vim.api.nvim_create_user_command("SetLogLevel", function(opts)
        logging.set_level(opts.args)
        vim.notify("Log level set to " .. opts.args, vim.log.levels.INFO)
    end, { 
        desc = "Set log level (TRACE, DEBUG, INFO, WARN, ERROR)",
        nargs = 1,
        complete = function()
            return { "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }
        end
    })
    
    -- Command to check performance
    vim.api.nvim_create_user_command("CheckPerformance", function()
        vim.cmd("StartupTime")
    end, { desc = "Check Neovim startup performance" })
    
    -- Command to check swap files
    vim.api.nvim_create_user_command("CheckSwapFiles", function()
        local swap_dir = vim.fn.stdpath("state") .. "/swap"
        local swap_files = vim.fn.glob(swap_dir .. "/*", false, true)
        
        if #swap_files == 0 then
            vim.notify("No swap files found", vim.log.levels.INFO)
        else
            vim.notify("Found " .. #swap_files .. " swap files:", vim.log.levels.WARN)
            for _, file in ipairs(swap_files) do
                print("  " .. vim.fn.fnamemodify(file, ":t"))
            end
        end
    end, { desc = "Check for existing swap files" })
    
    -- Command to enable debug mode
    vim.api.nvim_create_user_command("DebugMode", function()
        logging.set_level("DEBUG")
        vim.opt.verbose = 1
        vim.notify("Debug mode enabled. Check logs with :ViewLogs", vim.log.levels.INFO)
    end, { desc = "Enable debug mode with verbose logging" })
    
    -- Command to disable debug mode
    vim.api.nvim_create_user_command("NormalMode", function()
        logging.set_level("INFO")
        vim.opt.verbose = 0
        vim.notify("Normal mode enabled", vim.log.levels.INFO)
    end, { desc = "Disable debug mode" })
end

return M