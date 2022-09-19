(el-get-bundle lsp-mode)
(el-get-bundle lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(custom-set-variables
 '(lsp-diagnostics-provider :flycheck)
 '(lsp-ui-doc-show-with-cursor t)
 '(lsp-ui-doc-alignment 'window))

;; Patch
;; https://github.com/emacs-lsp/lsp-ui/issues/184#issuecomment-1158057166
(with-eval-after-load 'lsp-ui-sideline
  (defun lsp-ui-sideline--align (&rest lengths)
    "Align sideline string by LENGTHS from the right of the window."
    (cons (+ (apply '+ lengths)
             (if (display-graphic-p) 1 2))
          'width))
  (defun lsp-ui-sideline--compute-height () nil))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp--formatting-indent-alist `(web-mode . web-mode-code-indent-offset)))
