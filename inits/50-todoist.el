(el-get-bundle emacs-todoist)

(with-eval-after-load 'todoist
  (setq todoist-token (funcall (plist-get (nth 0 (auth-source-search :host "todoist.com" :max 1)) :secret))))
