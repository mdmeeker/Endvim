-- Debugging utilities
-------------------------------------------------------------------------

local M = {}

-- Debug commands
M.setup_commands = function()
    local logging = require("config.logging")
    
    -- Command to view logs
    vim.api.nvim_create_user_command("ViewLogs", function()
        local log_file = logging.get_log_file()
        if vim.fn.filereadable(log_file) == 1 then
            vim.cmd("split " .. vim.fn.fnameescape(log_file))
        else
            vim.notify("Log file not found: " .. log_file, vim.log.levels.WARN)
        end
    end, { desc = "View Neovim debug logs" })
    
    -- Command to clear logs
    vim.api.nvim_create_user_command("ClearLogs", function()
        logging.clear()
        vim.notify("Logs cleared", vim.log.levels.INFO)
    end, { desc = "Clear debug logs" })
    
    -- Command to set log level
    vim.api.nvim_create_user_command("SetLogLevel", function(opts)
        local level = opts.args:upper()
        if vim.tbl_contains({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }, level) then
            logging.set_level(level)
            vim.notify("Log level set to " .. level, vim.log.levels.INFO)
        else
            vim.notify("Invalid log level: " .. level, vim.log.levels.ERROR)
        end
    end, { 
        desc = "Set log level (TRACE, DEBUG, INFO, WARN, ERROR)",
        nargs = 1,
        complete = function()
            return { "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }
        end
    })
    
    -- Command to check swap files
    vim.api.nvim_create_user_command("CheckSwapFiles", function()
        local swap_dir = vim.fn.stdpath("state") .. "/swap"
        local swap_files = {}
        
        -- Use readdir for better performance
        local files = vim.fn.readdir(swap_dir)
        if files then
            for _, file in ipairs(files) do
                if vim.fn.isdirectory(swap_dir .. "/" .. file) == 0 then
                    table.insert(swap_files, file)
                end
            end
        end
        
        if #swap_files == 0 then
            vim.notify("No swap files found", vim.log.levels.INFO)
        else
            vim.notify("Found " .. #swap_files .. " swap files:", vim.log.levels.WARN)
            for _, file in ipairs(swap_files) do
                print("  " .. file)
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
    
    -- Command to check performance (alternative to StartupTime)
    vim.api.nvim_create_user_command("CheckPerformance", function()
        local start_time = vim.loop.hrtime()
        vim.cmd("redraw")
        local end_time = vim.loop.hrtime()
        local duration = (end_time - start_time) / 1000000
        vim.notify(string.format("Redraw time: %.2fms", duration), vim.log.levels.INFO)
    end, { desc = "Check Neovim performance" })
end

return M