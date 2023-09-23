(el-get-bundle graphql-mode)

(defun my/graphql-mode-hook ()
  (company-mode 1)
  (turn-on-smartparens-strict-mode)
  (highlight-indent-guides-mode 1)
  (display-line-numbers-mode 1))

(add-hook 'graphql-mode-hook 'my/graphql-mode-hook)

(el-get-bundle graphql)
