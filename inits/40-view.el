(defun my/setup-view-mode-keymap ()
  (let ((keymap view-mode-map))
    (define-key keymap (kbd "h") 'backward-char)
    (define-key keymap (kbd "j") 'next-line)
    (define-key keymap (kbd "k") 'previous-line)
    (define-key keymap (kbd "l") 'forward-char)

    (define-key keymap (kbd "e") 'forward-word)

    (define-key keymap (kbd "b")   'scroll-down)
    (define-key keymap (kbd "SPC") 'scroll-up)

    (define-key keymap (kbd "g") 'beginning-of-buffer)
    (define-key keymap (kbd "G") 'end-of-buffer)
    (define-key keymap (kbd "<") 'beginning-of-buffer)
    (define-key keymap (kbd ">") 'end-of-buffer)))

(defun my/view-mode-hook ()
  (my/setup-view-mode-keymap))

(add-hook 'view-mode-hook 'my/view-mode-hook)

(defun my/toggle-view-mode ()
  "view-mode と通常モードの切り替えコマンド"
  (interactive)
  (cond (view-mode
         (hl-line-mode -1)
         (view-mode -1))
        (t
         (hl-line-mode 1)
         (view-mode 1))))
