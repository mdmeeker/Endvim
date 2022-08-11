(local {: setup} (require :neoscroll))
(. setup (:setup {:hide_cursor true
                  :stop_eof true
                  :respect_scrolloff false
                  :cursor_scrolls_alone true
                  :easing_function "sine"
                  :pre_hook nil
                  :post_hook nil
                  :performance_mode false})) 


(local {: config} (require :neoscroll.config))
(. config (:set_mappings {:<A-e> ["scroll" ["-vim.wo.scroll" "true" "350" "'sine'"]]
                          :<A-d> ["scroll" ["vim.wo.scroll" "true" "350" "'sine'"]]
                          :<A-r> ["scroll" ["-0.10" "false" "100" nil]]
                          :<A-f> ["scroll" ["0.10" "false" "100" nil]]}))
