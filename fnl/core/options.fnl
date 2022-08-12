(import-macros {: set!} :macros.option-macros)
(import-macros {: let!} :macros.variable-macros)

;; add Mason to path
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))

;; improve updatetime for quicker refresh + gitsigns
(set! updatetime 200)
(set! timeoutlen 500)

;; Encoding
(set! encoding :utf-8)
(set! fileencoding :utf-8)

;; Set shortmess
(set! shortmess :filnxtToOFatsIc)

;; trailing characters setup
(set! list)
(set! listchars {:tab "> " :nbsp "␣" :trail "-"})

;; don't wrap text
(set! nowrap)

;; Use clipboard outside Neovim
(set! clipboard :unnamedplus)

;; Enable mouse input
(set! mouse :a)

;; Disable swapfiles and enable undofiles
(set! undofile)
(set! noswapfile)

;; Disable ruler
(set! noruler)

;; Disable showing mode 
(set! noshowmode)

;; Global statusline
(set! laststatus 3)

;; low cmdheight
(set! cmdheight 0)

;; Numbering
(set! nonumber)

;; Smart search
(set! smartcase)
(set! incsearch)
(set! hlsearch)
(set! inccommand "nosplit")

;; Indentation rules
(set! copyindent)
(set! smartindent)
(set! preserveindent)

;; Indentation level; set to 2 spaces
;; File specific is done in the ftplugin particular...
(set! tabstop 2)
(set! shiftwidth 2)
(set! softtabstop 2)

;; Expand tabs
(set! expandtab)

;; Enable cursorline/column
(set! cursorline)
(set! nocursorcolumn)

;; Automatic split locations
(set! splitright)
(set! splitbelow)

;; Scroll off
(set! scrolloff 8)

;; cmp options
(set! completeopt [:menu :menuone :preview :noinsert])

;; colorscheme
(set! background :dark)
(set! guifont "Liga SFMono Nerd Font:h15")

;; line numbering
(set! number)
(set! relativenumber)

;; Set shell
(set! shell "/bin/zsh")

;; NOTE: NEOVIM UI THINGS FOLLOW
;; NOTE: AUTOCHDIR
(set! autochdir)

;; Colorscheming for Material
(set! termguicolors true)
(let! material_style "deep ocean")


;; Memory and performance
(set! hidden true)
(set! timeoutlen 500)
(set! lazyredraw true)
(set! synmaxcol 240)


