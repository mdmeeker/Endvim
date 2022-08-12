(local tt (require :toggleterm))

(tt.setup {
          :size 20
          :open_mapping "<a-t>"
          :hide_numbers true
          :shade_filetypes []
          :shade_terminals true
          :start_in_insert true
          :insert_mappings true
          :persist_size true
          :direction "float"
          :shell vim.o.shell
          :float_opts {
            :border :curved
            :width 130
            :winblend 0
            :highlights {
              :border "Normal"
              :background "Normal"
            }
          }
          })
