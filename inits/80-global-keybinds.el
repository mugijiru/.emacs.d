(if (eq window-system 'ns)
    (progn
          (setq ns-alternate-modifier (quote super)) ;; option  => super
          (setq ns-command-modifier (quote meta))))  ;; command => meta

;; C-h を backspace に
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

;; M-g rをstring-replaceに割り当て
(global-set-key (kbd "M-g r") 'replace-string)

;; C-\ で skk が有効になるように
(global-set-key (kbd "C-\\") 'skk-mode)

;; C-s で helm-swoop を代わりに使うことにした
(global-set-key (kbd "C-s") 'helm-swoop)

;; Shift+矢印でwindow移動
(windmove-default-keybindings)

;; ¥ ではなく \ になるように調整
(define-key global-map [?¥] [?\\])
(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])

;; multiple-cursors
(global-set-key (kbd "C-:") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; helm
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-;") 'helm-for-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; zoom-window
(global-set-key (kbd "C-x 1") 'zoom-window-zoom)

;; neotree
(global-set-key [f8] 'neotree-toggle)

;; org-mode
(setq my/org-mode-prefix-key "C-c o ")
(global-set-key (kbd (concat my/org-mode-prefix-key "a")) 'org-agenda)
(global-set-key (kbd (concat my/org-mode-prefix-key "c")) 'org-capture)
(global-set-key (kbd (concat my/org-mode-prefix-key "l")) 'org-store-link)

;; with keychord
(key-chord-define-global "jk" 'hydra-usefull-commands/body)
