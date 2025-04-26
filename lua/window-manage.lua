require("which-key").add({ { "<leader>w", group = "[W]indow" } }, { mode = "n" })
vim.keymap.set("n", "<leader>wl", "<cmd>vsplit<CR><C-W>l", { desc = "New window on the right" })
vim.keymap.set("n", "<leader>wh", "<cmd>vsplit<CR>", { desc = "New window on the left" })
vim.keymap.set("n", "<leader>wj", "<cmd>split<CR><C-W>j", { desc = "New window on the below" })
vim.keymap.set("n", "<leader>wk", "<cmd>split<CR>", { desc = "New window on the above" })
vim.keymap.set("n", "<leader>wd", "<cmd>close<CR>", { desc = "Close window" })
vim.keymap.set("n", "<leader>ww", "<cmd>wincmd =<CR>", { desc = "resize window" })
if vim.g.vscode then
  return
end
vim.keymap.set("n", "<leader>tl", "<cmd>tabnext<CR>", { desc = "Tab previous" })
vim.keymap.set("n", "<leader>th", "<cmd>tabprevious<CR>", { desc = "Tab next" })
vim.keymap.set("n", "<leader>tn", "<cmd>tab split<CR><cmd>tcd %:h<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<CR>", { desc = "Close tab" })

vim.keymap.set("n", "<leader>bl", "<cmd>bNext<CR>", { desc = "Buffer previous" })
vim.keymap.set("n", "<leader>bh", "<cmd>bprev<CR>", { desc = "Buffer next" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd%<CR>", { desc = "Close tab" })

local function move_focus(vim_direction)
  local direction = {
    ["h"] = "L",
    ["j"] = "D",
    ["k"] = "U",
    ["l"] = "R",
  }
  local winid = vim.fn.win_getid()
  local keys = vim.api.nvim_replace_termcodes("<C-W>" .. vim_direction, true, false, true)
  vim.api.nvim_feedkeys(keys, "xn", false)
  if vim.fn.win_getid() == winid then
    if vim.env.TMUX then
      os.execute("tmux select-pane -" .. direction[vim_direction])
    end
  end
end
vim.keymap.set({ "n", "v" }, "<C-h>", function() move_focus("h") end, { desc = "Focus to the window on the left" })
vim.keymap.set({ "n", "v" }, "<C-j>", function() move_focus("j") end, { desc = "Focus to the window on the below" })
vim.keymap.set({ "n", "v" }, "<C-k>", function() move_focus("k") end, { desc = "Focus to the window on the above" })
vim.keymap.set({ "n", "v" }, "<C-l>", function() move_focus("l") end, { desc = "Focus to the window on the right" })

require("which-key").add({ { "<leader>n", group = "[N]ew" } }, { mode = "n" })
vim.keymap.set("n", "<leader>nt", function()
  local pwd = vim.fn.getcwd()
  vim.cmd('silent !tmux split-window -c "' .. pwd .. '"')
end, { desc = "[N]ew [T]erminal" })

local api = require("nvim-tree.api")

local function edit_or_open()
  local node = api.tree.get_node_under_cursor()
  if node == nil then
    return
  end

  if node.nodes ~= nil then
    if node.open ~= nil then
      api.node.open.edit()
    end
  else
    -- open file
    if vim.fn.confirm("Open file?", "&Yes\n&No", 1) == 1 then
      api.node.open.edit()
      -- Close the tree if file was opened
      api.tree.close()
    end
  end
end
local function node_collapse()
  local node = api.tree.get_node_under_cursor()
  if node == nil then
    return
  end
  if vim.fn.isdirectory(node.absolute_path) == 1 then
    if not node.open then
      api.node.navigate.parent(node)
    else
      api.node.open.edit(node)
    end
  else
    api.node.navigate.parent(node)
  end
end
local change_cwd = function()
  local node = api.tree.get_node_under_cursor()
  if node == nil then
    return
  end
  local new_path = nil
  if vim.fn.isdirectory(node.absolute_path) == 1 then
    new_path = node.absolute_path
  else
    new_path = vim.fn.fnamemodify(node.absolute_path, ":h")
  end
  api.tree.change_root(new_path)
  vim.cmd("cd " .. new_path)
  vim.print("Changed directory to " .. new_path)
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" },
  {
    pattern = "NvimTree*",
    callback = function()
      vim.keymap.set("n", "l", edit_or_open, { desc = "Edit Or Open", buffer = true })
      vim.keymap.set("n", "h", node_collapse, { desc = "Collapse node", buffer = true })
      vim.keymap.set("n", ".", change_cwd, { desc = "Collapse All", buffer = true })
    end,
  })
