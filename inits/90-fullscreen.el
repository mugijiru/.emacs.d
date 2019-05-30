(if (or (eq window-system 'ns) (eq window-system 'mac))
    (add-hook 'window-setup-hook
              (lambda ()
                (set-frame-parameter nil 'fullscreen 'fullboth))))
