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

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define pretty-hydra-lsp (:separator "-" :color blue :foreign-keys warn :title "LSP" :quit-key "q")
    ("Find"
     (("t" lsp-find-type-definition "type")
      ("x" lsp-find-definition      "definition")
      ("r" lsp-find-references      "references")
      ("i" lsp-find-implementation  "implementation")
      ("d" lsp-find-declaration     "declaration"))

     "Code"
     (("m" lsp-rename        "rename")
      ("f" lsp-format-buffer "format buffer")
      ("F" lsp-format-region "format region"))

     "UI"
     (("M" lsp-ui-imenu                      "imenu")
      ("V" lsp-ui-flycheck-list              "flycheck list")
      ("X" lsp-ui-peek-find-definitions      "def")
      ("R" lsp-ui-peek-find-references       "refs")
      ("I" lsp-ui-peek-find-implementations  "implementation")
      ("S" lsp-ui-peek-find-workspace-symbol "symbol"))

     "Server"
     (("W" lsp-workspace-restart  "Restart")
      ("Q" lsp-workspace-shutdown "Shutdown")
      ("d" lsp-describe-session   "Session")
      ("D" lsp-disconnect         "Disconnect")))))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp--formatting-indent-alist `(web-mode . web-mode-code-indent-offset))
  (add-to-list 'lsp--formatting-indent-alist `(tsx-ts-mode . typescript-ts-mode-indent-offset))
  (add-to-list 'lsp-file-watch-ignored-directories "tmp")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]vendor\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "hello-friend-ng")
  (add-to-list 'lsp-file-watch-ignored-directories "ox-hugo"))
