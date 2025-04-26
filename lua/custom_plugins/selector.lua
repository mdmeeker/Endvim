local ts_utils = require('nvim-treesitter.ts_utils')
local M = {}

M.bufnr = -1
M.line = -1
M.col = -1
M.nodes = {}
M.node_index = -1
M.end_pos = false

-- M.update_cursor = function()
--   local node = M.nodes[M.node_index]
--   ts_utils.update_selection(M.bufnr, node)
-- end

M.is_empty_line = function(line)
  return vim.fn.getline(line):match("^%s*$") ~= nil
end

M.current_or_next_non_empty_line = function()
  local current_line = vim.fn.line('.')
  if not M.is_empty_line(current_line) then
    return current_line
  end
  local last_line = vim.fn.line('$')
  while vim.fn.getline(current_line):match("^%s*$") ~= nil do
    current_line = current_line + 1
    if current_line > last_line then
      return -1 -- Reached the end of the file
    end
  end
  return current_line
end

M.current_or_next_nonempty_row = function()
  -- Move to the first non-space character on the line
  local col = vim.fn.col('.')
  if vim.fn.getline(M.line):sub(col, col):match("%s") then
    local pos = vim.fn.searchpos("\\S", "cn", M.line)
    if pos[2] > 0 then
      col = pos[2]
    else
      print("No non-space character found on the line")
      return -1
    end
  end
  M.col = col
end

M.get_node = function()
  M.bufnr = vim.api.nvim_get_current_buf()
  M.win = vim.api.nvim_get_current_win()
  M.line = M.current_or_next_non_empty_line()
  if M.line == -1 then
    print("Your cursor is at the end of the file")
    return nil
  end
  M.current_or_next_nonempty_row()
  vim.fn.cursor(M.line, M.col)

  local node = ts_utils.get_node_at_cursor(M.win)
  local _, sc = node:start()
  local _, ec = node:end_()
  if M.col - sc < ec - M.col then
    M.end_pos = false
  else
    M.end_pos = true
  end
  M.nodes = { node }
  M.node_index = 1
end

M.select_parent = function()
  if M.node_index == #M.nodes then
    local parent = M.nodes[M.node_index]
    local node_len = ts_utils.node_length(parent)
    while ts_utils.node_length(parent) <= node_len do
      local new_parent = parent:parent()
      if new_parent == nil then
        print("No parent found")
        return nil
      end
      parent = new_parent
    end
    table.insert(M.nodes, parent)
  end
  M.node_index = M.node_index + 1
  ts_utils.update_selection(M.bufnr, M.nodes[M.node_index])
end

M.select_child = function()
  if M.node_index > 1 then
    M.node_index = M.node_index - 1
    -- M.update_cursor()
    ts_utils.update_selection(M.bufnr, M.nodes[M.node_index])
    return
  end
  local child = M.nodes[M.node_index]
  local node_len = ts_utils.node_length(child)
  while ts_utils.node_length(child) >= node_len do
    if child:child_count() == 0 then
      return
    end
    child = child:child(0)
  end
  table.insert(M.nodes, 1, child)
  M.node_index = 1
  -- M.update_cursor()
  ts_utils.update_selection(M.bufnr, M.nodes[M.node_index])
end

M.select_older_sibling = function()
  local sibling = ts_utils.get_previous_node(M.nodes[M.node_index], true, true)
  if sibling == nil then
    return
  end
  if M.nodes[M.node_index] == sibling then
    error("I'm the oldest and not nil")
  end
  for _ = 1, M.node_index - 1 do
    table.remove(M.nodes, 1)
  end
  M.nodes[1] = sibling
  M.node_index = 1
  if #M.nodes > 1 then
    if not ts_utils.is_parent(M.nodes[2], M.nodes[1]) then
      for _ = 2, #M.nodes do
        table.remove(M.nodes, 2)
      end
    end
  end
  -- M.update_cursor()
  ts_utils.update_selection(M.bufnr, M.nodes[M.node_index])
end

M.select_younger_sibling = function()
  local sibling = ts_utils.get_next_node(M.nodes[M.node_index], true, true)
  if sibling == nil then
    return
  end
  if M.nodes[M.node_index] == sibling then
    error("I'm the oldest and not nil")
  end
  for _ = 1, M.node_index - 1 do
    table.remove(M.nodes, 1)
  end
  M.nodes[1] = sibling
  M.node_index = 1
  if #M.nodes > 1 then
    if not ts_utils.is_parent(M.nodes[2], M.nodes[1]) then
      for _ = 2, #M.nodes do
        table.remove(M.nodes, 2)
      end
    end
  end
  -- M.update_cursor()
  ts_utils.update_selection(M.bufnr, M.nodes[M.node_index])
end


M.run = function()
  M.get_node()
  if M.node_index < 0 then
    print("No node found")
    return nil
  end
  ts_utils.update_selection(M.bufnr, M.nodes[M.node_index])
  vim.keymap.set("v", "j", M.select_child, { buffer = true })
  vim.keymap.set("v", "k", M.select_parent, { buffer = true })
  vim.keymap.set("v", "h", M.select_older_sibling, { buffer = true })
  vim.keymap.set("v", "l", M.select_younger_sibling, { buffer = true })
  M.allowed_keys = { "h", "j", "k", "l", "o" }
  M.ns_id = vim.on_key(function(key, typed)
    if typed ~= nil then
      key = typed
    end
    key = vim.fn.keytrans(key)
    if key == nil or key == "" then
      return
    end
    -- vim.print("Pressed " .. key)
    local key_accepted = false
    for _, allowed_key in pairs(M.allowed_keys) do
      if key == allowed_key then
        key_accepted = true
      end
    end
    if not key_accepted then
      -- vim.print("Exit selection mode with key " .. key)
      vim.keymap.del('v', 'j', { buffer = true })
      vim.keymap.del('v', 'k', { buffer = true })
      vim.keymap.del('v', 'h', { buffer = true })
      vim.keymap.del('v', 'l', { buffer = true })
      vim.on_key(nil, M.ns_id)
      M.ns_id = nil
    end
  end, M.ns_id)
end

vim.keymap.set({ "n", "v" }, "<leader><CR>", M.run)
