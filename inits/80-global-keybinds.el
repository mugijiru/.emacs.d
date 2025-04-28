(if (eq window-system 'ns)
    (progn
      (setq ns-alternate-modifier (quote super)) ;; option  => super
      (setq ns-command-modifier (quote meta))))  ;; command => meta

(keyboard-translate ?\C-h ?\C-?)
(keymap-global-set "C-h" nil)

(keymap-global-set "M-g r" 'replace-string)

(keymap-global-set "C-\\" 'skk-mode)

(keymap-global-set "C-s" 'swiper)

(keymap-global-set "C-x o" 'ace-window)

(windmove-default-keybindings)

(keymap-global-set "C-/" 'undo-fu-only-undo)
(keymap-global-set "C-M-/" 'undo-fu-only-redo)

(define-key global-map [?¥] [?\\])
(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])

;; multiple-cursors
(keymap-global-set "C-:" 'mc/edit-lines)
(keymap-global-set "C->" 'mc/mark-next-like-this)
(keymap-global-set "C-<" 'mc/mark-previous-like-this)
(keymap-global-set "C-c C-<" 'mc/mark-all-like-this)

(keymap-global-set "M-x" 'counsel-M-x)
(keymap-global-set "M-y" 'counsel-yank-pop)
(keymap-global-set "C-x b" 'counsel-switch-buffer)
(keymap-global-set "C-x C-f" 'counsel-find-file)

(keymap-global-set "C-x 1" 'zoom-window-zoom)

(keymap-global-set "<f8>" 'neotree-toggle)

(keymap-global-set "C-;" 'embark-act)

(setq my/org-mode-prefix-key "C-c o ")
(keymap-global-set (concat my/org-mode-prefix-key "a") 'org-agenda)
(keymap-global-set (concat my/org-mode-prefix-key "c") 'org-capture)
(keymap-global-set (concat my/org-mode-prefix-key "l") 'org-store-link)

(key-chord-define-global "jk" 'my/context-hydra)

;; Don't ask yes or no.
(defalias 'yes-or-no-p 'y-or-n-p)
