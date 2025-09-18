return {
    -- Main DAP plugin
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "jbyuki/one-small-step-for-vimkind", -- Lua debugging
      },
      lazy = true,
      config = function()
        local dap = require("dap")
        
        -- CodeLLDB adapter for C/C++/Rust
        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
          },
        }
        
        -- LLDB configurations for C/C++/Rust
        local lldb_configs = {
          {
            name = "lldb: Launch (console)",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = true,
          },
          {
            name = "lldb: Launch (integratedTerminal)",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
          },
        }
        
        -- .NET Core configurations
        local coreclr_configs = {
          {
            name = "netcoredbg",
            type = "coreclr",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
            end,
          },
        }
        
        -- Configure for different languages (mimicking nyoom's module checks)
        
        -- C/C++ configuration
        local has_cc = pcall(require, "clangd_extensions")
        if has_cc then
          dap.configurations.c = lldb_configs
          dap.configurations.cpp = lldb_configs
        end
        
        -- C# configuration
        dap.configurations.cs = coreclr_configs
        dap.adapters.coreclr = {
          type = "executable",
          command = "/usr/local/bin/netcoredbg/netcoredbg",
          args = { "--interpreter=vscode" },
        }
        
        -- Rust configuration
        dap.configurations.rust = lldb_configs
        
        -- Lua debugging configuration
        dap.configurations.lua = {
          {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance",
          },
        }
        
        dap.adapters.nlua = function(callback, config)
          callback({
            type = "server",
            host = config.host or "127.0.0.1",
            port = config.port or 8086,
          })
        end
        
        -- Python debugging configuration
        local python_debug_path = "~/.virtualenvs/debugpy/bin/python"
        
        -- Check if mason is available and use its debugpy path
        local mason_ok, mason_registry = pcall(require, "mason-registry")
        if mason_ok and mason_registry.is_installed("debugpy") then
          python_debug_path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
        end
        
        require("dap-python").setup(python_debug_path)
      end,
    },
  
    -- DAP UI for better debugging experience
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
      config = function()
        local dapui = require("dapui")
        
        -- Copy nyoom's dapui configuration
        dapui.setup({
          icons = {
            expanded = "",
            collapsed = "",
            current_frame = "",
          },
          controls = {
            icons = {
              pause = "",
              play = "契",
              step_into = "",
              step_over = "",
              step_out = "",
              step_back = "",
              run_last = "",
              terminate = "",
            },
          },
          floating = {
            border = "single",
          },
        })
        
        -- Auto-open/close DAP UI
        local dap = require("dap")
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end,
      keys = {
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end, desc = "Down" },
        { "<leader>dk", function() require("dap").up() end, desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end, desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
        { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      },
    },
  }