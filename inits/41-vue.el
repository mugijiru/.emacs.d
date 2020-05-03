(define-auto-insert "\\.vue$" "template.vue")

(el-get-bundle vue-mode)
(el-get-bundle pug-mode)
(defun my/css-mode-hook ()
  ;; (make-local-variable 'flycheck-checker)
  ;; (setq flycheck-checker 'css-stylelint)
  (setq-local flycheck-checker 'css-stylelint)
  (rainbow-mode 1))

(defun my/vue-mode-hook ()
  (display-line-numbers-mode t)

  (lsp)

  (flycheck-mode 1))

(add-hook 'css-mode-hook 'my/css-mode-hook)
(add-hook 'vue-mode-hook 'my/vue-mode-hook)

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define css-mode (:quit-key "q" :title (concat (all-the-icons-alltheicon "css3") " CSS"))
    ("Edit"
     (("v" my/replace-var "replace-var")))))
