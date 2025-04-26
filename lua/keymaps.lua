vim.keymap.set("n", "s", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "S", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("n", "r", '"_r', { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>P", '"0P', { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "NP", ":m '}>+1<CR>gv=gvzz", { noremap = true, silent = true })
vim.keymap.set("v", "PP", ":m '{>+1<CR>gv=gvzz", { noremap = true, silent = true })

local whichkey = require("which-key")
if not vim.g.vscode then
  -- File Explorer
  -- vim.keymap.set("n", "<leader>e", "<cmd>Neotree filesystem reveal right<CR>", { desc = "[E]xplorer" })
  vim.keymap.set("n", "<F2>",
    function()
      local api = require("nvim-tree.api")
      local bufname = vim.fn.bufname()
      if bufname == "" or bufname:match(vim.fn.expand("~/notes")) then
        api.tree.toggle()
        return
      end
      api.tree.toggle({
        path = vim.fn.fnameescape(vim.fn.getcwd(
          -1,
          vim.api.nvim_win_get_tabpage(vim.api.nvim_get_current_win()))),
        find_file = true,
        update_root = true
      })
    end, { desc = "[E]xplorer" })
  vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "[Z]en Mode" })

  -- Search
  local tb = require("telescope.builtin")
  local multigrep = require('custom_plugins.multigrep')
  whichkey.add({ { "<leader>s", group = "[S]earch" } }, { mode = { "n", "v" } })
  vim.keymap.set("n", "<leader> ", tb.buffers, { desc = "[B]uffers" })
  vim.keymap.set("n", "<leader>sf", tb.find_files, { desc = "[F]iles" })
  vim.keymap.set("n", "<leader>sF", function() tb.find_files{hidden=true, no_ignore=true, no_ignore_parent=true} end, { desc = "[F]iles" })
  vim.keymap.set("n", "<leader>sg", multigrep.live_multigrep, { desc = "[G]rep" })
  vim.keymap.set("n", "<leader>sG", tb.current_buffer_fuzzy_find, { desc = "[G]rep Current Buffer" })
  vim.keymap.set("n", "<leader>ss", '<cmd>Telescope luasnip<CR>', { desc = "[S]nippets" })
  vim.keymap.set("n", "<leader>sn", function() tb.find_files({ cwd = vim.fn.expand("~/notes") }) end,
    { desc = "[N]otes" })
  vim.keymap.set("n", "<leader>st", function() tb.grep_string({ cwd = vim.fn.expand("~/notes"), search = "( )" }) end,
    { desc = "[T]odos" })
  vim.keymap.set("n", "<leader>se", function() tb.symbols{ sources = {'emoji'} } end, { desc = "[G]rep" })
  vim.keymap.set("n", "<leader>gw", "<cmd>Telescope git_worktree<CR>", { desc = "[W]orktree" })
  vim.keymap.set("n", "<leader>nd", "<cmd>ObsidianToday<CR>", { desc = "[N]ew [D]aily note" })
  vim.keymap.set("n", "<leader>nn", "<cmd>ObsidianNew<CR>", { desc = "[N]ew [N]ote" })

  -- harpoon
  local harpoon = require("harpoon")

  whichkey.add({ { "<leader>h", group = "[H]arpoon" } }, { mode = { "n", "v" } })
  vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[A]dd" })
  vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[L]ist" })

  vim.keymap.set("n", "<leader>hq", function() harpoon:list():select(1) end, { desc = "[1]" })
  vim.keymap.set("n", "<leader>hw", function() harpoon:list():select(2) end, { desc = "[2]" })
  vim.keymap.set("n", "<leader>he", function() harpoon:list():select(3) end, { desc = "[3]" })
  vim.keymap.set("n", "<leader>hr", function() harpoon:list():select(4) end, { desc = "[4]" })
  vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "[N]ext" })
  vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "[P]rev" })
else
  -- File Explorer
  vim.keymap.set("n", "<leader>e",
    "<cmd>lua require('vscode').action('workbench.files.action.showActiveFileInExplorer')<CR>", { desc = "[E]xplorer" })

  -- Search
  vim.keymap.set("n", "<leader>sf", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>",
    { desc = "[F]iles" })
  vim.keymap.set("n", "<leader>sg", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>",
    { desc = "[G]rep" })
  -- Terminal and Code Actions / Debug
  vim.keymap.set({ "n", "v" }, "<leader>t",
    "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>", { desc = "[T]erminal" })
end

-- Git
whichkey.add({ { "<leader>g", group = "[G]it" } }, { mode = { "n", "v" } })
vim.keymap.set("n", "<leader>ga", require('gitsigns').stage_hunk, { desc = "[G]it [A]dd hunk" })
vim.keymap.set("v", "<leader>ga", require('gitsigns').stage_hunk, { desc = "[G]it [A]dd selectedc" })
vim.keymap.set("n", "<leader>gA", require('gitsigns').stage_buffer, { desc = "[G]it [A]dd buffer" })
vim.keymap.set("n", "<leader>gr", require('gitsigns').reset_hunk, { desc = "[G]it [R]eset hunk" })
vim.keymap.set("v", "<leader>gr", require('gitsigns').reset_hunk, { desc = "[G]it [R]eset selected" })
vim.keymap.set("n", "<leader>gR", require('gitsigns').reset_buffer, { desc = "[G]it [R]eset buffer" })
vim.keymap.set("n", "<leader>gp", require('gitsigns').preview_hunk, { desc = "[G]it [P]review hunk" })
vim.keymap.set({ "o", "x" }, "ih", require('gitsigns').select_hunk, { desc = "[G]it [P]review hunk" })
if not vim.g.vscode then
  vim.keymap.set("n", "<leader>gs", "<cmd>LazyGit<CR>", { desc = "[S]tatus", silent = true })
  vim.keymap.set("n", "<leader>gl", "<cmd>LazyGitFilterCurrentFile<CR>",
    { desc = "[L]ogs (current buffer)", silent = true })
  vim.keymap.set("n", "<leader>gL", "<cmd>LazyGitFilter<CR>", { desc = "[L]ogs", silent = true })
else
  vim.keymap.set("n", "<leader>gs", "<cmd>lua require('vscode').action('workbench.view.scm')<CR>",
    { desc = "[S]tatus", silent = true })
end
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>cq', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
whichkey.add({ { "<leader>c", group = "[C]ode" } }, { mode = "n" })
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    if vim.g.vscode then
      vim.keymap.set({ "n", "v" }, "<leader>cb",
        "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
      vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
      vim.keymap.set({ "n", "v" }, "<leader>cd",
        "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
      vim.keymap.set({ "n", "v" }, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
      vim.keymap.set({ "n", "v" }, "<leader>cl", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
    else
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "[D]ecleration", buffer = ev.buf })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "[D]efinition", buffer = ev.buf })
      if not vim.g.vscode then
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover", buffer = ev.buf })
        vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations,
          { desc = "[I]mplementations", buffer = ev.buf })
        vim.keymap.set('n', '<leader>cd', require('telescope.builtin').diagnostics,
          { desc = "[D]ecleration", buffer = ev.buf })
      else
        vim.keymap.set({ "n", "v" }, "K", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
        vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations,
          { desc = "[I]mplementations", buffer = ev.buf })
        vim.keymap.set('n', '<leader>cd', require('telescope.builtin').diagnostics,
          { desc = "[D]ecleration", buffer = ev.buf })
      end
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = "[R]name", buffer = ev.buf })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "[A]ction", buffer = ev.buf })
      local buf_keymaps = vim.api.nvim_buf_get_keymap(ev.buf, 'n')
      local found = false
      for _, keymap in ipairs(buf_keymaps) do
        if keymap.lhs == vim.g.mapleader .. 'cf' then
          found = true
          break
        end
      end
      if not found then
        vim.keymap.set('n', '<leader>cf', function()
          vim.lsp.buf.format { async = true }
        end, { desc = "[F]ormat", buffer = ev.buf, noremap = false })
      end
      vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { desc = "[S]ignature", buffer = ev.buf })
    end
  end,
})

-- Debugging Keymaps only when entering a buffer with a debugger
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" },
  {
    pattern = { "*.c", "*.cpp", "*.py" },
    callback = function()
      if vim.g.vscode then
        -- Basic debugging keymapa, feel free to change to your liking!
        vim.keymap.set("n", "<F5>", "<cmd>lua require('vscode').action('workbench.action.debug.continue')<CR>",
          { buffer = true, desc = 'Debug: Start/Continue' })
        vim.keymap.set("n", "<S-F5>", "<cmd>lua require('vscode').action('workbench.action.debug.stop')<CR>",
          { buffer = true, desc = 'Debug: Terminate' })
        vim.keymap.set("n", "<A-l>", "<cmd>lua require('vscode').action('workbench.action.debug.stepInto')<CR>",
          { buffer = true, desc = 'Debug: Step Into' })
        vim.keymap.set("n", "<A-j>", "<cmd>lua require('vscode').action('workbench.action.debug.stepOver')<CR>",
          { buffer = true, desc = 'Debug: Step Over' })
        vim.keymap.set("n", "<A-h>", "<cmd>lua require('vscode').action('workbench.action.debug.stepOut')<CR>",
          { buffer = true, desc = 'Debug: Step Out' })
        vim.keymap.set("n", "<C-A-j>", "<cmd>lua require('vscode').action('workbench.action.debug.callStackDown')<CR>",
          { buffer = true, desc = 'Debug: Call Stack Down' })
        vim.keymap.set("n", "<C-A-k>", "<cmd>lua require('vscode').action('workbench.action.debug.callStackUp')<CR>",
          { buffer = true, desc = 'Debug: Call Stack Up' })
        vim.keymap.set("n", "<leader>cb", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>",
          { buffer = true, desc = 'Debug: Toggle Breakpoint' })
      else
        -- Basic debugging keymapa, feel free to change to your liking!
        vim.keymap.set("n", "<F5>", function() require('dap').continue() end,
          { buffer = true, desc = 'Debug: Start/Continue' })
        vim.keymap.set("n", "<S-F5>", function() require('dap').terminate() end,
          { buffer = true, desc = 'Debug: Terminate' })
        vim.keymap.set("n", "<A-l>", function() require('dap').step_into() end,
          { buffer = true, desc = 'Debug: Step Into' })
        vim.keymap.set("n", "<A-j>", function() require('dap').step_over() end,
          { buffer = true, desc = 'Debug: Step Over' })
        vim.keymap.set("n", "<A-h>", function() require('dap').step_out() end,
          { buffer = true, desc = 'Debug: Step Out' })
        vim.keymap.set("n", "<C-A-j>", function() require('dap').down() end,
          { buffer = true, desc = 'Debug: Step Over' })
        vim.keymap.set("n", "<C-A-k>", function() require('dap').up() end,
          { buffer = true, desc = 'Debug: Step Over' })
        vim.keymap.set("n", "<A-q>", function() require('dapui').toggle() end,
          { buffer = true, desc = 'Debug: See last session result.' })
        vim.keymap.set("n", "<leader>cb", function() require('dap').toggle_breakpoint() end,
          { buffer = true, desc = 'Debug: Toggle Breakpoint' })
      end
    end
  }
)

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" },
  {
    pattern = { "*/mfem/**/*.cpp", "*/mfem/**/*.hpp", "*/mfem/**/*.h", "*/mfem/**/*.c" },
    callback = function()
      -- Set a keymap for <leader>cf to compile the C++ file
      vim.api.nvim_buf_set_keymap(
        0,
        "n",
        "<leader>cf",
        ":w<CR>:!astyle --options="
        .. vim.fn.expand("~")
        .. "/mfem/mfem.astylerc "
        .. vim.fn.expand("%:p")
        .. "<CR>:e<CR>",
        { noremap = true, silent = true, desc = "[F]ormat (astyle-mfem)" }
      )
      vim.cmd("setlocal tabstop=3")
      vim.cmd("setlocal softtabstop=3")
      vim.cmd("setlocal shiftwidth=3")
      vim.cmd("setlocal expandtab")
    end
  }
)

if vim.fn.executable("latexmk") == 1 then
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "*.tex, *.bib",
    callback = function()
      vim.api.nvim_command("setlocal spelllang=en_us spell")
      vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>",
        { buffer = true, desc = "[C]ompile" })
      vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<CR>", { buffer = true, desc = "[C]lean" })
      vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { buffer = true, desc = "[V]iew" })
      vim.keymap.set("n", "<leader>lV", "<cmd>VimtexView<CR><cmd>silent !open -a Skim<CR>",
        { buffer = true, silent = true, desc = "[V]iew" })
    end
  })
end
require("nvim-treesitter.configs").setup({
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["sna"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
      },
      swap_previous = {
        ["spa"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["gnc"] = { query = "@class.inner", desc = "Next class start" },
        ["gnC"] = { query = "@class.outer", desc = "Next class outer start" },
        ["gnf"] = { query = { "@function.outer", "@field_declaration" }, desc = "Next function outer start" },
        ["gnb"] = { query = "@block.outer", desc = "Next block start" },
        ["gna"] = { query = "@parameter.inner", desc = "Next parameter start" },
        ["gnA"] = { query = "@parameter.outer", desc = "Next parameter start" },
      },
      goto_previous_start = {
        ["gpc"] = { query = "@class.inner", desc = "Previous class start" },
        ["gpC"] = { query = "@class.outer", desc = "Previous class start" },
        ["gpf"] = { query = { "@function.outer", "@field_declaration" }, desc = "Previous function outer start" },
        ["gpb"] = { query = "@block.outer", desc = "Previous block start" },
        ["gpa"] = { query = "@parameter.inner", desc = "Previous parameter start" },
        ["gpA"] = { query = "@parameter.outer", desc = "Previous parameter start" },
      },
    },
  },
})

vim.keymap.set("n", "<leader>o", "<cmd>! open -R %:p<CR>", { desc = "[O]pen in Finder", silent=true})
vim.keymap.set({ "n", "x", "o" }, "<leader>f", function() require("flash").jump() end, { desc = "[F]lash" })
vim.keymap.set({ "n", "x", "o" }, "<leader>F", function() require("flash").jump({ forward = false }) end,
  { desc = "[F]lash back" })
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "[R]emote Flash" })
require('custom_plugins.selector')
require('custom_plugins.latex_keymaps')
require('custom_plugins.open_link')
