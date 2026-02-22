(el-get-bundle exec-path-from-shell)

(setopt exec-path-from-shell-variables '("PATH" "MANPATH" "SSH_AUTH_SOCK"))

(when (memq window-system '(mac ns pgtk))
  (exec-path-from-shell-initialize))
