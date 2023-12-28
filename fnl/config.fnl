(require-macros :macros)

;; You can use the `colorscheme` macro to load a custom theme, or load it manually
;; via require. This is the default:

(set! background :dark)
(colorscheme no-clown-fiesta)

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

(map! [n] :<esc> :<esc><cmd>noh<cr> {:desc "No highlight escape"})

;; sometimes you want to modify a plugin thats loaded from within a module. For 
;; this you can use the `after` function

(after :neorg
       {:load {:core.dirman {:config {:workspaces {:main "~/neorg"}}}}})


;; NOTE: Settings

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

;; NOTE: To be able to move in and out of the terminal instances

(fn _G.set_terminal_keymaps []
  (map! [t] "<esc>" "<C-\\><C-n>" {:buffer 0})
  (map! [t] "<C-h>" "<Cmd>wincmd h<CR>" {:buffer 0})
  (map! [t] "<C-j>" "<Cmd>wincmd j<CR>" {:buffer 0})
  (map! [t] "<C-k>" "<Cmd>wincmd k<CR>" {:buffer 0})
  (map! [t] "<C-l>" "<Cmd>wincmd l<CR>" {:buffer 0}))

(vim.api.nvim_command "autocmd! TermOpen term://* lua set_terminal_keymaps()")


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
(map! [n] "<F1>" "<cmd>ToggleTerm direction=float<CR>")
(map! [n] "<F2>" "<cmd>NvimTreeToggle<CR>")
(map! [n] "<F3>" "<cmd>ToggleTerm direction=vertical size=75<CR>")

;; A mix of things...
(map! [n] "<leader>y" "<cmd>Trouble workspace_diagnostics<CR>")
(map! [n] "<leader>s" "<cmd>SymbolsOutline<CR>")

;; Comment toggling
(map! [n] "<leader>c" "<cmd>CommentToggle<CR>")
(map! [x] "<leader>c" "<cmd>'<,'>CommentToggle<CR>")
