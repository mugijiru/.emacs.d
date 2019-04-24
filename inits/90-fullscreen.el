(if (eq window-system 'ns)
    (add-hook 'window-setup-hook
              (lambda ()
                (set-frame-parameter nil 'fullscreen 'fullboth))))
