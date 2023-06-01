(local {: setup} (require :nvim-tree))

(setup {
        :disable_netrw true
        :hijack_netrw true
        :hijack_cursor true
        :update_cwd false
        :git {:enable true :ignore true :timeout 500}
        :hijack_directories {:enable false}
        :actions {:open_file {:resize_window true}}
        :filters {:custom [".git"] :exclude []}
        :renderer {
                   :add_trailing false
                   :group_empty false
                   :highlight_git false
                   :highlight_opened_files "none"
                   :root_folder_modifier ":~"
                   :indent_markers {
                                    :enable false
                                    :icons { :corner "│ " :edge   "│ " :none   "  "}} 
                   :icons { 
                           :webdev_colors true 
                           :git_placement "before" 
                           :padding " " 
                           :symlink_arrow " ➛ "
                           :show {:file true :folder true :folder_arrow false :git true}
                           :glyphs {
                                    :default ""
                                    :symlink ""
                                    :folder {
                                             :arrow_open "v"
                                             :arrow_closed ">"
                                             :default ""
                                             :open ""
                                             :empty ""
                                             :empty_open ""
                                             :symlink ""
                                             :symlink_open ""}
                                    :git { :unstaged "" :staged "S" :unmerged "" :renamed "➜" :untracked "U" :deleted "" :ignored "◌"}}}}
         :diagnostics {
                       :enable true
                       :icons {
                               :hint ""
                               :info  ""
                               :warning ""
                               :error ""}}
         :update_focused_file {
                               :enable true
                               :update_cwd true
                               :ignore_list {}}
         :git {
               :enable true
               :ignore true
               :timeout 500}})
