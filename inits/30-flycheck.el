(el-get-bundle flycheck)
(el-get-bundle flycheck-pos-tip)

(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode))
