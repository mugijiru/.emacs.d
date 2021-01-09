;; Mac の場合にフルスクリーンにする
;; 2020-01-08 yabai WM を導入したのでフルスクリーンじゃない方がよくなったのでコメントアウト
;; (if (or (eq window-system 'ns) (eq window-system 'mac))
;;     (add-hook 'window-setup-hook
;;               (lambda ()
;;                 (set-frame-parameter nil 'fullscreen 'fullboth))))

;; X Window system の場合にフルスクリーンにする
(if (eq window-system 'x)
    (add-hook 'window-setup-hook
              (lambda ()
                (set-frame-parameter nil 'fullscreen 'fullboth)
                (set-frame-position nil 0 0))))
