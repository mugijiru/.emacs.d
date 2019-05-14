(el-get-bundle rbenv)
(global-rbenv-mode)
(el-get-bundle enh-ruby-mode)
(el-get-bundle ruby-end)

(with-eval-after-load 'enh-ruby-mode
  (setq enh-ruby-add-encoding-comment-on-save nil))

(defun my/enh-ruby-mode-hook ()
  (display-line-numbers-mode 1))

(add-hook 'enh-ruby-mode-hook 'my/enh-ruby-mode-hook)
