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

-- equation*
s("eqn", fmt([[
\begin{equation*}
	<>
\end{equation*}
]], { i(1) }, { delimiters = "<>" })),

-- align
s("ali", fmt([[
\begin{align}
	<>
\end{align}
]], { i(1) }, { delimiters = "<>" })),

-- align*
s("alin", fmt([[
\begin{align*}
	<>
\end{align*}
]], { i(1) }, { delimiters = "<>" })),

-- itemize
s("item", fmt([[
\begin{itemize}
	<>
\end{itemize}
]], { i(1) }, { delimiters = "<>" })),

-- enumerate
s("enum", fmt([[
\begin{enumerate}
	<>
\end{enumerate}
]], { i(1) }, { delimiters = "<>" })),


-- thm/proof couple
s("thm", fmt([[
\begin{theorem}[]
	<>
\end{theorem}
\begin{proof}

\end{proof}
]], { i(1) }, { delimiters = "<>" })),

-- lemma/proof couple
s("lem", fmt([[
\begin{lemma}[]
	<>
\end{lemma}
\begin{proof}

\end{proof}
]], { i(1) }, { delimiters = "<>" })),

-- Corollary/proof couple
s("cor", fmt([[
\begin{corollary}[]
	<>
\end{corollary}
\begin{proof}

\end{proof}
]], { i(1) }, { delimiters = "<>" })),

-- Proposition/proof couple
s("prop", fmt([[
\begin{proposition}[]
	<>
\end{proposition}
\begin{proof}

\end{proof}
]], { i(1) }, { delimiters = "<>" })),

-- Problem/Solution couple
s("ps", fmt([[
\begin{problem}[]
	<>
\end{problem}
\begin{solution}

\end{solution}
]], { i(1) }, { delimiters = "<>" })),

-- Example
s("ex", fmt([[
\begin{example}[]
	<>
\end{example}
]], { i(1) }, { delimiters = "<>" })),


-- Definition
s("def", fmt([[
\begin{definition}[]
	<>
\end{definition}
]], { i(1) }, { delimiters = "<>" })),

-- Remark
s("rem", fmt([[
\begin{remark}[]
	<>
\end{remark}
]], { i(1) }, { delimiters = "<>" })),












}
