(el-get-bundle magit)

(with-eval-after-load 'magit
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/ghub/lisp")))

(el-get-bundle orgit)
