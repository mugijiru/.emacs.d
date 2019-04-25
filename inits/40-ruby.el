(el-get-bundle rbenv)
(global-rbenv-mode)
(el-get-bundle enh-ruby-mode)

(with-eval-after-load 'enh-ruby-mode
  (setq enh-ruby-add-encoding-comment-on-save nil))
