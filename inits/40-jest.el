(el-get-bundle jest-test-mode)

(with-eval-after-load 'jest-test-mode
  (let ((keymap jest-test-mode-map))
    (define-key keymap (kbd "C-c C-c") 'jest-test-run-at-point)))
