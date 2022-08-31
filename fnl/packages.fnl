(import-macros {: packadd! : pack : rock : use-package! : rock! : unpack! : echo!} :macros)

;; Load packer
(echo! "Loading Packer")
(packadd! packer.nvim)

;; include modules
(echo! "Compiling Modules")
(include :fnl.modules)

;; Setup packer
(echo! "Initiating Packer")
(let [packer (require :packer)]
   (packer.init {:git {:clone_timeout 300}
                 :compile_path (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")
                 :auto_reload_compiled false
                 :display {:non_interactive true}}))

;; Core packages
(use-package! :wbthomason/packer.nvim {:opt true})
(use-package! :nvim-lua/plenary.nvim {:module :plenary})

;; To install a package with Nyoom you must declare them here and run 'nyoom sync'
;; on the command line, then restart nvim for the changes to take effect
;; The syntax is as follows: 

;; (use-package! :username/repo {:opt true
;;                               :defer reponame-to-defer
;;                               :call-setup pluginname-to-setup
;;                               :cmd [:cmds :to :lazyload]
;;                               :event [:events :to :lazyload]
;;                               :ft [:ft :to :load :on]
;;                               :requires [(pack :plugin/dependency)]
;;                               :run :commandtorun
;;                               :as :nametoloadas
;;                               :branch :repobranch
;;                               :setup (fn [])
;;                                        ;; same as setup with packer.nvim)})
;;                               :config (fn [])})
;;                                        ;; same as config with packer.nvim)})


;; ---------------------
;; Put your plugins here
;; ---------------------

;; extra colorschemes
(use-package! :EdenEast/nightfox.nvim)
(use-package! :shaunsingh/nord.nvim)

;; extra functionality
(use-package! :karb94/neoscroll.nvim 
              {:config (fn []
                           ((. (require :neoscroll) :setup)
                            {:hide_cursor true :stop_eof true :respect_scrolloff false :cursor_scrolls_alone true :easing_function "sine" :pre_hook nil :post_hook nil :performance_mode false})
                           ((. (require :neoscroll.config) :set_mappings)
                            {:<A-e> ["scroll" ["-vim.wo.scroll" "true" "350" "'sine'"]]
                             :<A-d> ["scroll" ["vim.wo.scroll" "true" "350" "'sine'"]]
                             :<A-r> ["scroll" ["-0.10" "false" "100" nil]]
                             :<A-f> ["scroll" ["0.10" "false" "100" nil]]}))})
(use-package! :terrortylor/nvim-comment
              {:config (fn []
                         ((. (require :nvim_comment) :setup)
                          {:marker_padding true :comment_empty true :comment_empty_trim_whitespace true :create_mappings true :operator_mapping "<leader>g" :hook nil}))})

(use-package! :akinsho/toggleterm.nvim
              {:config (fn [] 
                         ((. (require :toggleterm) :setup) 
                          {:size 20 :open_mapping "<a-t>" :hide_numbers true :shade_filetypes [] :shade_terminals true :start_in_insert true :insert_mappings true :persist_size false :shell vim.o.shell :float_opts {:border :curved :width 130 :winblend 0 :highlights {:border "Normal" :background "Normal"}}}))})


;; Send plugins to packer
(echo! "Installing Packages")
(unpack!)
