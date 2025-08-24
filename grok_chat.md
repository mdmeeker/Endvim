1. Overall Architecture

Modular Config: The setup uses a directory-based structure (~/.config/nvim/lua/{config,plugins}) with separate files for options, keymaps, and plugins, ensuring scalability and maintainability. Lazy.nvim manages plugins with lazy-loading to keep startup time under 50ms.
Workflow Separation: Designed for disjoint workflows (LaTeX/Typst vs. programming) using filetype-based (ft) and directory-based (vim.g.workflow) plugin loading to optimize performance and relevance.
Extensibility: The config is built to evolve, with placeholders for future additions (e.g., Avante.nvim, debugging tools) and Lua-based customization to match your comfort level.

2. Core Design Choices

Theme and UI:

Everforest: Chosen for its dark, soft-contrast aesthetic, compatible with WezTerm’s GPU rendering and tmux sessions. Applied via sainnhe/everforest with priority 1000 for early loading.
Navigation: telescope.nvim provides fuzzy finding for files and grep, enhancing productivity across workflows.
Statusline: lualine.nvim with Everforest theme displays git status, LSP info, and buffer details.


Keybindings: Vim-style navigation (<C-h/j/k/l> for windows, <leader> as space) ensures consistency with your preference, extended with which-key.nvim for hints.
Performance: Lazy-loading and minimal plugin overlap (e.g., Treesitter for syntax) keep the setup lightweight, critical for SSH/tmux usage.
Error Handling: Integrated LSP diagnostics (nvim-lspconfig, nvim-lsp-lines) and quickfix lists (:copen, <leader>de, <leader>le) for comprehensive error display.

3. Workflows and Tooling

LaTeX/Typst Workflow (Note-taking, Studying, Reading):

Tools:

vimtex for LaTeX with latexmk and Preview.app (macOS native) for forward/inverse search.
typst-preview.nvim with typst CLI for modern Typst support, using Preview for live preview.
MacTeX for LaTeX compilation.


Design Choices:

<leader>l prefix for LaTeX mappings (e.g., <leader>ll for compile, <leader>lp for view).
SyncTeX enabled for navigation, with AppleScript for inverse search in Preview.
Conditional loading (ft = "tex") to isolate from programming plugins.


Integration: Works with toggleterm.nvim for compilation, zoxide for project navigation, and eza for file listing.


Programming Workflow (Python/uv, C++, Julia):

Tools:

nvim-lspconfig with pyright (Python with uv support), clangd (C++), julials (Julia).
nvim-cmp for autocompletion, nvim-treesitter for syntax.
vim-slime and julia-vim for REPL integration.
uv for Python dependency management, cmake for C++ builds.


Design Choices:

<leader>p prefix for programming mappings (e.g., <leader>tp for Python REPL).
LSP diagnostics tailored to uv’s Python path, with lsp-lines for inline feedback.
Conditional loading (ft = "py", ft = "julia") to separate from LaTeX.


Integration: toggleterm.nvim runs uv run python and julia, zoxide navigates code dirs, eza lists project files.


Org-mode Workflow (Organization):

Tools: nvim-orgmode with Treesitter for Org file support.
Design Choices:

<leader>o prefix for Org mappings (e.g., <leader>oa for agenda, <leader>oc for capture).
Universal loading (ft = "org") as it supports both workflows (study notes, project todos).


Integration: zoxide jumps to ~/org/, eza lists .org files, toggleterm runs shell commands.



4. Tooling Ecosystem

Neovim Core: v0.11.3 ensures modern Lua support and plugin compatibility.
Terminal:

WezTerm: Chosen for GPU-accelerated rendering, Everforest support, and Vim-like pane navigation (<Ctrl-h/j/k/l>).
tmux: Used for session persistence and pane splitting, configured with Vim bindings and Everforest colors.


Shell:

Zsh: Primary shell for SSH reliability, enhanced with Starship.rs for a fast prompt, eza for file listing, and zoxide for navigation. Includes zsh-autosuggestions and zsh-syntax-highlighting for interactivity.
Nushell: Secondary option for data-heavy Python/Julia tasks, deferred for now.


Security: API keys for Avante.nvim (deferred) managed via macOS Keychain with a script (~/bin/get_api_keys.sh), avoiding plain-text exposure.
Version Control: Suggested Git repo for ~/.config/nvim/ to track changes, compatible with your eza/zoxide aliases.

5. Plugin Management and Loading

Lazy.nvim: Central plugin manager with lazy-loading (event, ft) to optimize startup. Example: vimtex loads only for .tex files.
Conditional Loading: Uses vim.g.workflow (directory-based) and ft (filetype-based) to switch between LaTeX/Typst and programming contexts, minimizing overhead.

6. Deferred Choices

Avante.nvim: Postponed until API keys are set via Keychain. Will reintroduce with auto_suggestions = true for Cursor-like AI coding, integrated with LSP and toggleterm.
Debugging: nvim-dap and related plugins deferred but planned for C++/Python/Julia debugging.

7. Integration Points

Zsh/Starship: toggleterm.nvim uses /bin/zsh with Starship’s prompt, reflecting uv or LaTeX contexts.
eza/zoxide: Enhances file navigation and listing in toggleterm and tmux.
tmux/WezTerm: Synced Vim bindings (<Ctrl-h/j/k/l>) and Everforest theme across panes/sessions.
Cursor Compatibility: Config designed for migration into Cursor, with code blocks extracted into files for AI analysis.

Rationale Behind Choices

Performance: Lazy-loading and minimal plugins ensure fast startup, critical for SSH/tmux.
Workflow Focus: Disjoint loading prevents LaTeX/Typst tools from cluttering programming tasks, and vice versa.
Security: Keychain for API keys protects sensitive data, aligning with your concern.
User Comfort: Vim keybindings, Everforest, and Lua scripting match your preferences and skills.
Future-Proofing: Modular design and deferred Avante allow easy expansion as needs evolve.

Next Steps in Cursor
Since you have the codebase in Cursor:

Review Config: Use Cursor’s chat to ask, “Validate this Neovim config for errors” or “Suggest optimizations.”
Test Workflows:

LaTeX: Open main.tex, test <leader>ll, <leader>lp.
Programming: Open script.py, test <leader>tp.
Org-mode: Open notes.org, test <leader>oa.


Expand: Add debugging (nvim-dap) or tweak keymaps based on Cursor’s suggestions.
Reintroduce Avante: Once keys are set, paste lua/plugins/ai.lua back and sync.

First Thing to Try
Start with the LaTeX workflow in Cursor:

Open ~/.config/nvim/lua/plugins/lang.lua in Cursor.
Create ~/test/main.tex, load it, and test <leader>ll and <leader>lp.
Use Cursor’s chat to ask, “Debug this LaTeX setup if it fails.”