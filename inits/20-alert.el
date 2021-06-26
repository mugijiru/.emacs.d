(el-get-bundle alert)

(if (or (eq window-system 'ns) (eq window-system 'mac))
    (setq alert-default-style 'notifier) ;; use terminal-notifier
  (setq alert-default-style 'message))
