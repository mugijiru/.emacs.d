(if (eq window-system 'ns)
    (progn
      (setq ns-alternate-modifier (quote super)) ;; option  => super
      (setq ns-command-modifier (quote meta))))  ;; command => meta

(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

(global-set-key (kbd "M-g r") 'replace-string)

(global-set-key (kbd "C-\\") 'skk-mode)

(global-set-key (kbd "C-s") 'swiper)

(global-set-key (kbd "C-x o") 'ace-window)

(windmove-default-keybindings)

(global-set-key (kbd "C-/") 'undo-fu-only-undo)
(global-set-key (kbd "C-M-/") 'undo-fu-only-redo)

(define-key global-map [?¥] [?\\])
(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])

;; multiple-cursors
(global-set-key (kbd "C-:") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x b") 'counsel-switch-buffer)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(global-set-key (kbd "C-x 1") 'zoom-window-zoom)

(global-set-key [f8] 'neotree-toggle)

(setq my/org-mode-prefix-key "C-c o ")
(global-set-key (kbd (concat my/org-mode-prefix-key "a")) 'org-agenda)
(global-set-key (kbd (concat my/org-mode-prefix-key "c")) 'org-capture)
(global-set-key (kbd (concat my/org-mode-prefix-key "l")) 'org-store-link)

(key-chord-define-global "jk" 'pretty-hydra-usefull-commands/body)

;; Don't ask yes or no.
(defalias 'yes-or-no-p 'y-or-n-p)
