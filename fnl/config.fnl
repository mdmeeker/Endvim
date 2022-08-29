(require-macros :macros)
;; Place your private configuration here! Remember, you do not need to run 'nyoom
;; sync' after modifying this file!

;; You can use the `colorscheme` macro to load a custom theme, or load it manually
;; via require. This is the default:
(colorscheme carbon)

;; The set! macro sets vim.opt options. By default it sets the option to true 
;; Appending `no` in front sets it to false. This determines the style of line 
;; numbers in effect. If set to nonumber, line numbers are disabled. For 
;; relative line numbers, set 'relativenumber`
(set! nonumber)

;; The let option sets global, or `vim.g` options. 
;; Heres an example with localleader, setting it to <space>m
(let! maplocalleader " m")

;; map! is used for mappings
;; Heres an example, preseing esc should also remove search highlights
(map! [n] "<esc>" "<esc><cmd>noh<cr>")

;; Poke around the Nyoom code for more! The following macros are also available:
;; contains? check if a table contains a value
;; custom-set-face! use nvim_set_hl to set a highlight value
;; set! set a vim option
;; local-set! buffer-local set!
;; command! create a vim user command
;; local-command! buffer-local command!
;; autocmd! create an autocmd
;; augroup! create an augroup
;; clear! clear events
;; packadd! force load a plugin from /opt
;; colorscheme set a colorscheme
;; map! set a mapping
;; buf-map! bufer-local mappings
;; let! set a vim global
;; echo!/warn!/err! emit vim notifications


;; NOTE: SETTINGS
(set! clipboard :unnamedplus)
(set! undofile)
(set! noswapfile)
(set! noruler)
(set! noshowmode)

(set! cmdheight 0)

;; search, highlighting
(set! smartcase)
(set! incsearch)
(set! hlsearch)
(set! inccommand "nosplit")

;; trailing characters
(set! list)
(set! listchars {:tab "> " :nbsp "␣" :trail "-"})

;; indentation rules
(set! copyindent)
(set! smartindent)
(set! preserveindent)

(set! tabstop 2)
(set! shiftwidth 2)
(set! softtabstop 2)

(set! expandtab)

(set! cursorline)
(set! nocursorcolumn)

(set! splitright)
(set! splitbelow)

(set! completeopt [:menu :menuone :preview :noinsert])


(set! number)
(set! relativenumber)

(set! shell "/bin/zsh")

(set! autochdir)



;; NOTE: KEYBINDS


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
