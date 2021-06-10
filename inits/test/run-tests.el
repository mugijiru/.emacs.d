(add-to-list 'load-path (expand-file-name "~/.emacs.d/inits/test"))

(load "68-my-org-commands")

(if noninteractive
    (let ((ert-quiet t))
      (ert-run-tests-batch-and-exit)))
