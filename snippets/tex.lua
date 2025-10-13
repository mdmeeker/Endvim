-- Latex snippets

local ls  = require("luasnip")
local s,t = ls.snippet, ls.text_node
local i,r = ls.insert_node, ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s("np", t("\\newpage")),

    -- begin/end with mirrored env
    s("begin", fmt([[
\begin{<>}
	<>
\end{<>}
]], { i(1, "env"), i(2), r(1) }, { delimiters = "<>" })),

    -- equation
    s("eq", fmt([[
\begin{equation}
	<>
\end{equation}
]], { i(1) }, { delimiters = "<>" })),
}
