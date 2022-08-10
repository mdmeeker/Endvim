(set vim.notify (require :notify))
(local {: setup} (require :notify))
;; alternatively, set fade to fade_in_slide_out
(setup {:stages :fade
        :fps 60
        :icons {:ERROR ""
                :WARN ""
                :INFO ""
                :DEBUG ""
                :TRACE "✎"}})

