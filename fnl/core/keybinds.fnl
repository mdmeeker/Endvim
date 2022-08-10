(import-macros {: map!} :macros.keybind-macros)
(import-macros {: let!} :macros.variable-macros)

;; set leader key
(map! [n] "<Space>" "<no>")
(let! mapleader " ")
(let! maplocalleader " m")

;; Disable highlight on escape
(map! [n] "<esc>" "<esc><cmd>noh<cr>")

;; Easier command-line mode
(map! [n] ";" ":")

;; Some keybindings stolen from doom
(map! [n] "<leader>t" "<cmd>Telescope<CR>")

;; Some of my old keybinds
(map! [n] "<leader>y" "<cmd>Trouble workspace_diagnostics<CR>")

;; Window navigation...
(map! [n] "<C-h>" "<C-w>h")
(map! [n] "<C-j>" "<C-w>j")
(map! [n] "<C-k>" "<C-w>k")
(map! [n] "<C-l>" "<C-w>l")

;; Window resizing
(map! [n] "<A-h>" ":vertical resize -5<cr>")
(map! [n] "<A-j>" ":resize -5<cr>")
(map! [n] "<A-k>" ":resize +5<cr>")
(map! [n] "<A-l>" ":vertical resize +5<cr>")

;; Alt keys for faster access to quick commands
(map! [n] "<A-w>" "<cmd>w<CR>")
(map! [n] "<A-q>" "<cmd>q<CR>")

;; Faster tabbing in and out
(map! [n] "<" "<<")
(map! [n] ">" ">>")

;; The function keys
(map! [n] "<F1>" "<cmd>ToggleTerm<CR>")
(map! [n] "<F2>" "<cmd>NvimTreeToggle<CR>")
(map! [n] "<F3>" "<cmd>vnew term://zsh<CR>")

;; A mix of things...
(map! [n] "<leader>y" "<cmd>Trouble workspace_diagnostics<CR>")
(map! [n] "<leader>s" "<cmd>SymbolsOutline<CR>")

;; Comment toggling
(map! [n] "<leader>c" "<cmd>CommentToggle<CR>")
(map! [x] "<leader>c" "<cmd>'<,'>CommentToggle<CR>")
(map! [n] "<leader>p" "<cmd>Trouble workspace_diagnostics<CR>")

;; Gitsigns
(map! [n] "<leader>h" "<cmd>Gitsigns preview_hunk<CR>")
(map! [n] "<leader>j" "<cmd>Gitsigns reset_buffer<CR>")

;; Buffers
(map! [n] "<TAB>" "<cmd>bnext<CR>")
(map! [n] "<S-TAB>" "<cmd>bprevious<CR>")


;; Insert Mode
(map! [i] "<Esc>" "<Esc>`^")


