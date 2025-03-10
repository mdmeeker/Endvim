require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = "sine",    -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = function()       -- Center cursor after scrolling
        vim.cmd('normal! zz')
    end,
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
-- Smooth scroll by lines
t['<A-e>'] = {'scroll', {'-50', 'true', '500', [['sine']]}}
t['<A-d>'] = {'scroll', {'50', 'true', '500', [['sine']]}}

-- Smooth scroll by pages
t['<A-r>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '500', [['sine']]}}
t['<A-f>'] = {'scroll', {'vim.api.nvim_win_get_height(0)', 'true', '500', [['sine']]}}

require('neoscroll.config').set_mappings(t) 