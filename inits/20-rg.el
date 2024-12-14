(el-get-bundle rg)

(with-eval-after-load 'wgrep
  (autoload 'wgrep-rg-setup "wgrep-rg"))

(defun my/rg-mode-hook ()
  (wgrep-rg-setup))

(add-hook 'rg-mode-hook 'my/rg-mode-hook)

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define rg-mode (:separator "-" :quit-key "q" :title "rg-mode")
    ("General"
     (("m" rg-menu                    "Transient menu")
      ("w" wgrep-change-to-wgrep-mode "Wgrep")))))
