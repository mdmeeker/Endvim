(local {: setup} (require :nvim_comment))
(. setup (:setup {:marker_padding true 
                  :comment_empty true
                  :comment_empty_trim_whitespace true
                  :create_mappings true
                  :operator_mapping "<leader>g"
                  :hook nil}))

                  
                  
