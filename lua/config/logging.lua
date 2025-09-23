-- Logging configuration for debugging and monitoring

local M = {}

-- Log levels
local LOG_LEVELS = {
    TRACE = 0,
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4,
}

-- Current log level (can be changed at runtime)
local current_level = LOG_LEVELS.INFO

-- Log file path
local log_file = vim.fn.stdpath("state") .. "/logs/nvim-debug.log"

-- Ensure log directory exists
local function ensure_log_dir()
    local log_dir = vim.fn.fnamemodify(log_file, ":h")
    if vim.fn.isdirectory(log_dir) == 0 then
        vim.fn.mkdir(log_dir, "p")
    end
end

-- Write to log file
local function write_log(level, message, ...)
    if level < current_level then
        return
    end
    
    ensure_log_dir()
    
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local level_name = ({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" })[level + 1]
    local formatted_message = string.format(message, ...)
    local log_entry = string.format("[%s] [%s] %s\n", timestamp, level_name, formatted_message)
    
    local file = io.open(log_file, "a")
    if file then
        file:write(log_entry)
        file:close()
    end
end

-- Public logging functions
M.trace = function(message, ...)
    write_log(LOG_LEVELS.TRACE, message, ...)
end

M.debug = function(message, ...)
    write_log(LOG_LEVELS.DEBUG, message, ...)
end

M.info = function(message, ...)
    write_log(LOG_LEVELS.INFO, message, ...)
end

M.warn = function(message, ...)
    write_log(LOG_LEVELS.WARN, message, ...)
end

M.error = function(message, ...)
    write_log(LOG_LEVELS.ERROR, message, ...)
end

-- Set log level
M.set_level = function(level)
    if type(level) == "string" then
        level = LOG_LEVELS[level:upper()] or LOG_LEVELS.INFO
    end
    current_level = level
    M.info("Log level changed to %s", ({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" })[level + 1])
end

-- Get log file path
M.get_log_file = function()
    return log_file
end

-- Clear log file
M.clear = function()
    ensure_log_dir()
    local file = io.open(log_file, "w")
    if file then
        file:close()
        M.info("Log file cleared")
    end
end

-- Log Neovim events
M.log_event = function(event_name, data)
    M.debug("Event: %s | Data: %s", event_name, vim.inspect(data or {}))
end

-- Log performance metrics
M.log_performance = function(operation, start_time, end_time)
    local duration = (end_time - start_time) * 1000 -- Convert to milliseconds
    M.debug("Performance: %s took %.2fms", operation, duration)
end

return M