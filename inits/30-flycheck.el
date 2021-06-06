(el-get-bundle flycheck)
(el-get-bundle flycheck-pos-tip)

(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))
