local term_opts = { silent = true }

require("toggleterm").setup({
  open_mapping = [[<A-1>]],
  direction = 'float',
  shade_terminals = true,
  float_opts = {
    border = 'curved',
    winblend = 3,
  },
  -- Enable normal mode in terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    -- Set terminal keymaps
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
  end,
}) 