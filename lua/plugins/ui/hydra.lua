return {
    {
        "anuvyklack/hydra.nvim",
        keys = { "<leader>g", "<leader>v" },
        config = function()
            local Hydra = require("hydra")

            -- Git Hydra
            Hydra({
                name = "Git",
                hint = [[
 _J_: next hunk        _s_: stage hunk        _d_: show deleted   
 _K_: prev hunk        _u_: undo stage        _b_: blame line     
 _/_: show base file   _S_: stage buffer      _B_: blame show full
 _p_: preview hunk     _r_: reset hunk        _R_: reset buffer   

 _<Enter>_: Neogit              _q_: exit
]],
                config = {
                    color = 'red',
                    invoke_on_body = true,
                    hint = {
                        border = 'rounded',
                        position = 'middle'
                    },
                    on_enter = function()
                        vim.cmd 'mkview'
                        vim.cmd 'silent! %foldopen!'
                        require('gitsigns').toggle_linehl(true)
                    end,
                    on_exit = function()
                        local cursor_pos = vim.api.nvim_win_get_cursor(0)
                        vim.cmd 'loadview'
                        vim.api.nvim_win_set_cursor(0, cursor_pos)
                        vim.cmd 'normal zv'
                        require('gitsigns').toggle_linehl(false)
                        require('gitsigns').toggle_deleted(false)
                    end,
                },
                mode = {'n','x'},
                body = '<leader>g',
                heads = {
                    { 'J', 
                        function()
                            if vim.wo.diff then return ']c' end
                            vim.schedule(function() require('gitsigns').next_hunk() end)
                            return '<Ignore>'
                        end,
                        { expr = true, desc = 'next hunk' } },
                    { 'K', 
                        function()
                            if vim.wo.diff then return '[c' end
                            vim.schedule(function() require('gitsigns').prev_hunk() end)
                            return '<Ignore>'
                        end,
                        { expr = true, desc = 'prev hunk' } },
                    { 's', 
                        function()
                            local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
                            if mode == 'V' then
                                local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)
                                vim.api.nvim_feedkeys(esc, 'x', false)
                                vim.cmd("'<,'>Gitsigns stage_hunk")
                            else
                                vim.cmd("Gitsigns stage_hunk")
                            end
                        end,
                        { desc = 'stage hunk' } },
                    { 'u', function() require('gitsigns').undo_stage_hunk() end, { desc = 'undo stage' } },
                    { 'S', function() require('gitsigns').stage_buffer() end, { desc = 'stage buffer' } },
                    { 'p', function() require('gitsigns').preview_hunk() end, { desc = 'preview hunk' } },
                    { 'd', function() require('gitsigns').toggle_deleted() end, { nowait = true, desc = 'toggle deleted' } },
                    { 'b', function() require('gitsigns').blame_line() end, { desc = 'blame' } },
                    { 'B', function() require('gitsigns').blame_line({ full = true }) end, { desc = 'blame full' } },
                    { '/', function() require('gitsigns').show() end, { exit = true, desc = 'show base file' } },
                    { 'r', ':Gitsigns reset_hunk<CR>', { silent = true, desc = 'reset hunk' } },
                    { 'R', function() require('gitsigns').reset_buffer() end, { desc = 'reset buffer' } },
                    { '<Enter>', '<cmd>Neogit<CR>', { exit = true, desc = 'Neogit' } },
                    { 'q', nil, { exit = true, nowait = true, desc = 'exit' } }
                }
            })

            -- Options Hydra
            Hydra({
                name = 'Options',
                hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters  
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^              _q_
]],
                config = {
                    color = 'amaranth',
                    invoke_on_body = true,
                    hint = {
                        border = 'rounded',
                        position = 'middle'
                    },
                },
                mode = {'n','x'},
                body = '<leader>v',
                heads = {
                    { 'n', function() vim.o.number = not vim.o.number end, { desc = 'number' } },
                    { 'r', 
                        function()
                            if vim.o.relativenumber then
                                vim.o.relativenumber = false
                            else
                                vim.o.number = true
                                vim.o.relativenumber = true
                            end
                        end,
                        { desc = 'relativenumber' } },
                    { 'v', 
                        function()
                            if vim.o.virtualedit == 'all' then
                                vim.o.virtualedit = 'block'
                            else
                                vim.o.virtualedit = 'all'
                            end
                        end,
                        { desc = 'virtualedit' } },
                    { 'i', function() vim.o.list = not vim.o.list end, { desc = 'show invisible' } },
                    { 's', function() vim.o.spell = not vim.o.spell end, { exit = true, desc = 'spell' } },
                    { 'w', function() vim.o.wrap = not vim.o.wrap end, { desc = 'wrap' } },
                    { 'c', function() vim.o.cursorline = not vim.o.cursorline end, { desc = 'cursor line' } },
                    { 'q', nil, { exit = true, nowait = true, desc = 'exit' } }
                },
                hint = {
                    type = 'cmdline',
                    show_name = false,
                    funcs = {
                        ve = function() return vim.o.virtualedit == 'all' and '✓' or ' ' end,
                        list = function() return vim.o.list and '✓' or ' ' end,
                        spell = function() return vim.o.spell and '✓' or ' ' end,
                        wrap = function() return vim.o.wrap and '✓' or ' ' end,
                        cul = function() return vim.o.cursorline and '✓' or ' ' end,
                        nu = function() return vim.o.number and '✓' or ' ' end,
                        rnu = function() return vim.o.relativenumber and '✓' or ' ' end,
                    }
                }
            })
        end
    }
}
