local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values

local M = {}

M.live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  local current_file = vim.fn.expand("%")

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local parts = vim.split(prompt, "  ", { plain=true})
      if #parts == 0 then
        return nil
      end

      local search_term = table.remove(parts, 1)
      local args = { "rg", "-e", search_term }

      for _, piece in ipairs(parts) do
        if string.len(piece) > 0 then
          if piece:sub(1, 1) == "-" then
            table.insert(args, piece)
          else
            if piece == "%" then
              piece = current_file
            end
            table.insert(args, "-g")
            table.insert(args, piece)
          end
        end
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Multi Grep",
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty(),
  }):find()
end

return M
