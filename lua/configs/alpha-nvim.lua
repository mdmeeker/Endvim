-- Author: Matthew Meeker


local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end
local dashboard = require("alpha.themes.dashboard")

local enMorkVitLogn = {
  [[    ______                   _   _      __            _ __     ___   _           ]],
  [[   / ____/___     ____ ___  (_)_(_)____/ /__   _   __(_) /_   / (_)_(_)___ _____ ]],
  [[  / __/ / __ \   / __ `__ \/ __ \/ ___/ //_/  | | / / / __/  / / __ \/ __ `/ __ \]],
  [[ / /___/ / / /  / / / / / / /_/ / /  / ,<     | |/ / / /_   / / /_/ / /_/ / / / /]],
  [[/_____/_/ /_/  /_/ /_/ /_/\____/_/  /_/|_|    |___/_/\__/  /_/\____/\__, /_/ /_/ ]],
  [[                                                                   /____/        ]],
}

local header = {
	type = "text",
	val = {
		[[             o\             ]],
		[[   _________/__\__________  ]],
		[[  |                  - (  | ]],
		[[ ,'-.                 . `-| ]],
		[[(____".       ,-.    '   || ]],
		[[  |          /\,-\   ,-.  | ]],
		[[  |      ,-./     \ /'.-\ | ]],
		[[  |     /-.,\      /     \| ]],
		[[  |    /     \    ,-.     \ ]],
		[[  |___/_______\__/___\_____\]],
	},
	opts = {
		position = "center",
		hl = "Comment",
	},
}

local function getGreeting(name)
	local tableTime = os.date("*t")
	local hour = tableTime.hour
	local greetingsTable = {
		[1] = "  Good morning",
		[2] = "  Good afternoon",
		[3] = "  Good evening",
		[4] = "望 Good night",
	}
	local greetingIndex = 0
	if hour < 12 and hour >= 7 then
		greetingIndex = 1
	elseif hour >= 12 and hour < 18 then
		greetingIndex = 2
	elseif hour >= 18 and hour < 21 then
		greetingIndex = 3
	else
		greetingIndex = 4
	end
	return greetingsTable[greetingIndex] .. ", " .. name
end

local userName = "mjachi"
local greeting = getGreeting(userName)

local greetHeading = {
	type = "text",
	val = greeting,
	opts = {
		position = "center",
		hl = "String",
	},
}

local quote = [[
    "First, solve the problem.
    Then, write the code."
]]
local quoteAuthor = "John Johnson"
local fullQuote = quote .. "\n \n                  - " .. quoteAuthor

local fortune = {
	type = "text",
	val = fullQuote,
	opts = {
		position = "center",
		hl = "Comment",
	},
}

local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		text = txt,
		shortcut = sc,
		cursor = 6,
		width = 19,
		align_shortcut = "right",
		hl_shortcut = "Number",
		hl = "Function",
	}
	if keybind then
		opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
	end

	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end

local buttons = {
	type = "group",
	val = {
		button("s", "   Restore", ":SessionManager load_last_session<CR>"),
		button("r", "   Recents", ":Telescope oldfiles<CR>"),
		button("p", "   Projects", ":Telescope projects<CR>"),
		button("f", "   Search", ":Telescope find_files<CR>"),
		button("e", "   Create", ":ene <BAR> startinsert<CR>"),
		button("u", "   Update", ":PackerSync<CR>"),
		button("c", "   Config", ":e ~/.config/nvim/<CR>"),
		button("q", "   Quit", ":qa!<CR>"),
	},
	opts = {
		position = "center",
		spacing = 1,
	},
}

local section = {
	header = header,
	buttons = buttons,
	greetHeading = greetHeading,
	footer = fortune,
}

local opts = {
	layout = {
		{ type = "padding", val = 3 },
		section.header,
		{ type = "padding", val = 3 },
		section.greetHeading,
		section.pluginCount,
		{ type = "padding", val = 2 },
		section.buttons,
		{ type = "padding", val = 2 },
		section.footer,
	},
	opts = {
		margin = 44,
	},
}
alpha.setup(opts)
