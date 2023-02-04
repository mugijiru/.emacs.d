(el-get-bundle mocha)

(defun my/mocha-test-file ()
  (interactive)
  (if my/mocha-enable-p
      (mocha-test-file)))
