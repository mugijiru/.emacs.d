(el-get-bundle rainbow-mode)
(with-eval-after-load 'scss-mode
  (setq css-indent-offset 2))
(defun my/scss-mode-hook ()
  (flycheck-mode 1)

  (setq-local lsp-prefer-flymake nil) ;; flycheck が有効にならなくなるのを防ぐ
  (lsp)
  (lsp-ui-mode -1) ;; lsp-ui が有効だと画面上でガチャガチャ height とかの説明をしてうざいので

  ;; lsp-ui とかより後に設定しないと上書きされるのでここに移動した
  (setq-local flycheck-checker 'scss-stylelint)

  (company-mode 1)
  (display-line-numbers-mode 1)

  (rainbow-mode))
(add-hook 'scss-mode-hook 'my/scss-mode-hook)

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define scss-mode (:quit-key "q" :title (concat (all-the-icons-alltheicon "css3") " CSS"))
    ("Edit"
     (("v" my/replace-var "replace-var")))))
