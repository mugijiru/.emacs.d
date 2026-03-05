(setq interprogram-cut-function
      (lambda (text &optional push)
        (let ((process-connection-type nil))
          (call-process-region text nil "wl-copy"))))

(setq interprogram-paste-function
      (lambda ()
        (shell-command-to-string "wl-paste -n")))
