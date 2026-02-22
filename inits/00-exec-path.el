(el-get-bundle exec-path-from-shell)

(when (memq window-system '(mac ns pgtk))
  (exec-path-from-shell-initialize))
