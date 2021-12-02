(if (and (eq window-system 'x) (getenv "WSLENV"))
    (add-hook 'window-setup-hook
              (lambda ()
                (set-frame-parameter nil 'fullscreen 'fullboth)
                (set-frame-position nil 0 0))))
