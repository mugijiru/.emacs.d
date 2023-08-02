(el-get-bundle rbenv)

(global-rbenv-mode)

(el-get-bundle enh-ruby-mode)

(with-eval-after-load 'enh-ruby-mode
  (setq enh-ruby-add-encoding-comment-on-save nil)
  (setq enh-ruby-deep-indent-paren nil)
  (setq enh-ruby-deep-indent-construct nil)
  (setq enh-ruby-bounce-deep-indent nil))

(defun my/enh-ruby-mode-hook ()
  (company-mode 1)
  (origami-mode 1)
  (subword-mode 1)
  (lsp)
  (lsp-ui-mode 1)
  (add-hook 'before-save-hook #'lsp-format-buffer nil 'local)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode 1))

(add-hook 'enh-ruby-mode-hook 'my/enh-ruby-mode-hook)

(add-to-list 'context-skk-programming-mode 'enh-ruby-mode)

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define enh-ruby-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-alltheicon "ruby-alt") " Ruby commands"))
    ("Enh Ruby"
     (("{" enh-ruby-toggle-block "Toggle block")
      ("e" enh-ruby-insert-end "Insert end"))

     "LSP"
     (("i" lsp-ui-imenu "Imenu")
      ("f" lsp-ui-flycheck-list "Flycheck list"))

     "RSpec"
     (("s" rspec-verify "Run associated spec")
      ("m" rspec-verify-method "Run method spec")
      ("r" rspec-rerun "Rerun")
      ("l" rspec-run-last-failed "Run last failed"))

     "REPL"
     (("I" inf-ruby "inf-ruby"))

     "Other"
     (("j" dumb-jump-go "Dumb Jump")
      ("o" origami-hydra/body "Origami")))))
