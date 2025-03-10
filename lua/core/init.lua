-- Add this line wherever you initialize your plugins
require("plugins.indent-blankline").setup()

-- Near the top of the file, after loading plugins but before configuring them
local snippets = require("plugins.snippets")
snippets.setup() 