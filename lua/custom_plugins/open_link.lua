local function smart_open()
  local target = vim.fn.expand('<cfile>')
  if target:len() == 0 then
    return
  end

  -- URL detection: starts with scheme:// OR looks like a domain
  local function is_url(s)
    if s:match('^%a[%w+.-]*://') then return true end
    if s:match('^%w[%w%-]*%.%w+[%w%p]*$') then return true end
    return false
  end

  -- path resolve
  local resolved_path = nil
  if target:sub(1, 1) == '/' then
    -- Absolute path
    resolved_path = target
  else
    -- Relative path: try buffer dir then cwd
    local buf_dir = vim.fn.expand('%:p:h')
    local candidate = buf_dir .. '/' .. target
    if vim.fn.filereadable(candidate) == 1 or vim.fn.isdirectory(candidate) == 1 then
      resolved_path = candidate
    else
      candidate = vim.fn.getcwd() .. '/' .. target
      if vim.fn.filereadable(candidate) == 1 or vim.fn.isdirectory(candidate) == 1 then
        resolved_path = candidate
      end
    end
  end

  if resolved_path and vim.fn.filereadable(resolved_path) == 1 then
    vim.cmd('edit ' .. vim.fn.fnameescape(resolved_path))
  elseif resolved_path and vim.fn.isdirectory(resolved_path) == 1 then
    local opener = vim.fn.has('mac') == 1 and 'open'
                or vim.fn.has('win32') == 1 and 'start'
                or 'xdg-open'
    vim.fn.jobstart({ opener, resolved_path }, { detach = true })
  elseif is_url(target) then
    local opener = vim.fn.has('mac') == 1 and 'open'
                or vim.fn.has('win32') == 1 and 'start'
                or 'xdg-open'

    -- Add scheme if missing (defaults to https)
    if not target:match('^%a[%w+.-]*://') then
      target = 'https://' .. target
    end

    vim.fn.jobstart({ opener, target }, { detach = true })
  else
    print("Could not open: " .. target)
  end
end

vim.keymap.set('n', 'gx', smart_open, { desc = 'Smart open under cursor' })
txt = 'lua/custom_plugins'
