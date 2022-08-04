(import-macros {: map!} :macros.keybind-macros)
(import-macros {: let!} :macros.variable-macros)


;; Recreating most of the keybinds from old neovim configuration

(let! mapleader " ") ;; set leader key
(let! maplocalleader " m")


;; Normal mode mappings
(map! [n] "<esc>" "<esc><cmd>noh<cr>") ;; Disable highlight on escape
(map! [n] ";" ":") ;; Easier command-line mode


(map! [n] "<leader>t" "<cmd>Telescope<CR>") 
(map! [n] "<C-h>" "<C-w>h") ;; Navigate between the splits
(map! [n] "<C-j>" "<C-w>j")
(map! [n] "<C-k>" "<C-w>k")
(map! [n] "<C-l>" "<C-w>l")


(map! [n] "<A-h>" ":vertical resize -5<cr>") ;; Window resizing
(map! [n] "<A-j>" ":resize +5<cr>")
(map! [n] "<A-k>" ":resize -5<cr>")
(map! [n] "<A-l>" ":vertical resize +5<cr>")


;; Function keys mostly unused; F1,2,3 is mostly vestigial.
(map! [n] "<F1>" "<Nop>")
(map! [n] "<F2>" "<cmd>NvimTreeToggle<CR>")
(map! [n] "<F3>" "<Nop>")
(map! [n] "<F4>" "<Nop>")
(map! [n] "<F5>" "<Nop>")
(map! [n] "<F6>" "<Nop>")
(map! [n] "<F7>" "<Nop>")
(map! [n] "<F8>" "<Nop>")
(map! [n] "<F9>" "<Nop>")
(map! [n] "<F10>" "<Nop>")
(map! [n] "<F11>" "<Nop>")
(map! [n] "<F12>" "<Nop>")


;; Insert Mode mappings
(map! [i] "<Esc>" "<Esc>`^")
