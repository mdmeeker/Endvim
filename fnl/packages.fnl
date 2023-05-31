(import-macros {: packadd!
                : pack
                : rock
                : use-package!
                : rock!
                : nyoom-init-modules!
                : nyoom-compile-modules!
                : unpack!
                : autocmd!} :macros)

(packadd! packer.nvim)
(local {: build} (autoload :hotpot.api.make))
(local {: init} (autoload :packer))
(local {: echo!} (autoload :core.lib.io))

;; Load packer

(echo! "Loading Packer")
(local headless (= 0 (length (vim.api.nvim_list_uis))))
(init {;; :lockfile {:enable true
       ;;            :path (.. (vim.fn.stdpath :config) :/lockfile.lua)}
       :compile_path (.. (vim.fn.stdpath :config) :/lua/packer_compiled.lua)
       :auto_reload_compiled false
       :display {:non_interactive headless}})

;; compile healthchecks

(echo! "Compiling Nyoom Doctor")
(build (vim.fn.stdpath :config) {:verbosity 0}
       (.. (vim.fn.stdpath :config) :/fnl/core/doctor.fnl)
       (fn []
         (.. (vim.fn.stdpath :config) :/lua/health.lua)))

;; packer can manage itself

;; (use-package! :EdenEast/packer.nvim {:opt true :branch :feat/lockfile})
(use-package! :wbthomason/packer.nvim {:opt true})

;; libraries

(use-package! :nvim-lua/plenary.nvim {:module :plenary})
(use-package! :MunifTanjim/nui.nvim {:module :nui})
(use-package! :nyoom-engineering/oxocarbon.nvim)

;; include modules

(echo! "Initializing Module System")
(include :fnl.modules)
(nyoom-init-modules!)

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
(use-package! :aktersnurra/no-clown-fiesta.nvim)

;; Wakatime
(use-package! :wakatime/vim-wakatime)

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



;; Send plugins to packer

(echo! "Installing Packages")
(unpack!)

;; Compile modules 

(echo! "Compiling Nyoom Modules")
(nyoom-compile-modules!)
