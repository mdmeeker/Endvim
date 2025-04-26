-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
-- Grabbed from kicksatart.nvim
if vim.g.vscode then
  return {}
end

local servers = {
  c = vim.fn.executable('clangd'),
  python = vim.fn.executable('pyright')
}
local ft = {}
local ensure_installed = {}
if servers.c==1 then
  table.insert(ft, 'c')
  table.insert(ft, 'cpp')
  table.insert(ensure_installed, 'codelldb')
end
if servers.python==1 then
  table.insert(ft, 'python')
  table.insert(ensure_installed, 'debugpy')
end

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  ft = ft,
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    'rcarriga/nvim-dap-ui',           -- ui
    'nvim-neotest/nvim-nio',          -- ui dependency

    'williamboman/mason.nvim',        -- dap installer
    'jay-babu/mason-nvim-dap.nvim',   -- dap installer

    'julianolf/nvim-dap-lldb',        -- lldb debugger
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Install debuggers
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = ensure_installed,
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Error', linehl = '', numhl = '' })

    vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Continue' })
    dap.listeners.after.event_initialized['dapui_config'] = function()
      vim.keymap.set('n', '<leader><F5>', function() require('dap').run_to_cursor() end, { desc = 'Run to Cursor' })
      vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'Step Over' })
      vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'Step Into' })
      vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'Step Out' })
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      vim.keymap.del('n', '<leader><F5>')
      vim.keymap.del('n', '<F10>')
      vim.keymap.del('n', '<F11>')
      vim.keymap.del('n', '<F12>')
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      vim.keymap.del('n', '<leader><F5>')
      vim.keymap.del('n', '<F10>')
      vim.keymap.del('n', '<F11>')
      vim.keymap.del('n', '<F12>')
      dapui.close()
    end
  end,
}
