(import-macros {: use-package!} :macros)

; replacement for vim.notify
(use-package! :rcarriga/nvim-notify {:opt true
                                     :config (fn [] ((. (require :notify) :setup) {:background_color "#000000"}))
                                     :setup (fn []
                                              (set vim.notify
                                                   (fn [msg level opts]
                                                     ((. (require :packer) :loader) :nvim-notify)
                                                     (set vim.notify (require :notify))
                                                     (vim.notify msg level opts))))})


