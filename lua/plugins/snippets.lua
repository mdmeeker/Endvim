return {
  setup = function()
    local ls = require("luasnip")
    
    -- Debug print to verify the setup is running
    vim.notify("Setting up LuaSnip...")
    
    ls.setup({
      history = true,
      update_events = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    })

    -- Tell LuaSnip about the py.snippets file explicitly
    require("luasnip.loaders.from_snipmate").load({
      paths = { vim.fn.stdpath("config") .. "/snippets" },
      ft_paths = {
        python = { "py.snippets" }
      }
    })

    -- Create debug command
    vim.api.nvim_create_user_command("SnippetsDebug", function()
      vim.notify("Checking snippets setup...")
      local snippet_path = vim.fn.stdpath("config") .. "/snippets/py.snippets"
      vim.notify("Snippet file exists: " .. tostring(vim.fn.filereadable(snippet_path)))
      vim.notify("Available filetypes: " .. vim.inspect(ls.available_filetypes()))
      vim.notify("Python snippets: " .. vim.inspect(ls.get_snippets("python")))
    end, {})

    -- Add reload command
    vim.api.nvim_create_user_command("ReloadSnippets", function()
      vim.notify("Reloading snippets...")
      require("luasnip.loaders.from_snipmate").load({
        paths = { vim.fn.stdpath("config") .. "/snippets" }
      })
      vim.notify("Snippets reloaded")
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