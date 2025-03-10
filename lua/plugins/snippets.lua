return {
  setup = function()
    local ls = require("luasnip")
    local types = require("luasnip.util.types")
    
    -- Debug print to verify the setup is running
    vim.notify("Setting up LuaSnip...")
    
    -- Basic setup
    ls.setup({
      history = true,
      update_events = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      region_check_events = "CursorHold,InsertEnter",
      delete_check_events = "TextChanged,InsertLeave",
    })

    -- Load snippets after a short delay to ensure LuaSnip is initialized
    vim.defer_fn(function()
      -- Set up filetype for Python snippets
      ls.filetype_extend("python", {"py"})
      
      -- Load the snippets using the SnipMate loader
      require("luasnip.loaders.from_snipmate").load({
        paths = { vim.fn.stdpath("config") .. "/snippets" }
      })
      
      vim.notify("Snippets loaded")
    end, 100)

    -- Create debug command with better error handling
    vim.api.nvim_create_user_command("SnippetsDebug", function()
      vim.notify("Checking snippets setup...")
      local snippet_path = vim.fn.stdpath("config") .. "/snippets/py.snippets"
      vim.notify("Snippet file exists: " .. tostring(vim.fn.filereadable(snippet_path)))
      
      -- Get loaded filetypes
      local fts = {}
      for ft, _ in pairs(ls.snippets) do
        table.insert(fts, ft)
      end
      vim.notify("Loaded filetypes: " .. vim.inspect(fts))
      
      -- Get Python snippets directly from the snippets table
      local py_snippets = ls.snippets.python or {}
      vim.notify("Python snippets: " .. vim.inspect(py_snippets))
    end, {})

    -- Add reload command
    vim.api.nvim_create_user_command("ReloadSnippets", function()
      vim.notify("Reloading snippets...")
      -- Clear existing snippets
      for ft, _ in pairs(ls.snippets) do
        ls.snippets[ft] = {}
      end
      
      -- Reload snippets using the SnipMate loader
      require("luasnip.loaders.from_snipmate").load({
        paths = { vim.fn.stdpath("config") .. "/snippets" }
      })
    end, {})

    -- Keymaps for snippet navigation
    vim.keymap.set({"i", "s"}, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({"i", "s"}, "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    -- Optional: Add a keymap to reload snippets
    vim.keymap.set("n", "<leader>L", "<cmd>lua require('luasnip.loaders.from_snipmate').load({paths = {vim.fn.stdpath('config')..'/snippets'}})<CR>")
  end
} 