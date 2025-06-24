(el-get-bundle rbenv)

(global-rbenv-mode)

(el-get-bundle bundler)

(el-get-bundle yard-mode)

(el-get-bundle ruby-refactor)

(setopt ruby-refactor-add-parens t)
(setopt ruby-refactor-let-position 'closest)

(el-get-bundle enh-ruby-mode)

(with-eval-after-load 'enh-ruby-mode
  (setq enh-ruby-add-encoding-comment-on-save nil)
  (setq enh-ruby-deep-indent-paren nil)
  (setq enh-ruby-deep-indent-construct nil)
  (setq enh-ruby-bounce-deep-indent nil))

(defun my/ruby-modes-hook ()
  (origami-mode 1)
  (company-mode 1)
  (setq-local company-backends
              '(company-capf (company-keywords company-dabbrev-code) company-yasnippet company-files company-dabbrev))

  (subword-mode 1)
  (copilot-mode 1)
  (ruby-refactor-mode 1)
  (yard-mode 1)
  (eldoc-mode 1)
  (setq-local lsp-enable-indentation nil)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode 1))

(add-hook 'enh-ruby-mode-hook 'my/ruby-modes-hook)

(add-hook 'ruby-ts-mode-hook 'my/ruby-modes-hook)

(add-to-list 'context-skk-programming-mode 'enh-ruby-mode)

(add-to-list 'context-skk-programming-mode 'ruby-ts-mode)

(with-eval-after-load 'major-mode-hydra
  (let ((heads '("Ruby"
                 (("{" enh-ruby-toggle-block               "Toggle block")
                  ("e" enh-ruby-insert-end                 "Insert end")
                  ("p" ruby-refactor-add-parameter         "Add param")
                  ("i" ruby-refactor-convert-post-condition "if/unless block"))

                 "Extract to"
                 (("M" ruby-refactor-extract-to-method      "method")
                  ("V" ruby-refactor-extract-local-variable "local variable")
                  ("C" ruby-refactor-extract-constant       "constant"))

                 "RSpec"
                 (("l" ruby-refactor-extract-to-let "let")
                  ("s" rspec-verify                 "Run associated spec")
                  ("m" rspec-verify-method          "Run method spec")
                  ("r" rspec-rerun                  "Rerun")
                  ("f" rspec-run-last-failed        "Run last failed"))

                 "REPL"
                 (("I" inf-ruby "inf-ruby"))

                 "Other"
                 (("j" dumb-jump-go       "Dumb Jump")
                  ("o" origami-hydra/body "Origami")))))
    (eval `(major-mode-hydra-define enh-ruby-mode (:separator "-" :quit-key "q" :title (concat (nerd-icons-mdicon "nf-md-language_ruby") " Ruby commands"))
             (,@heads)))
    (eval `(major-mode-hydra-define ruby-ts-mode  (:separator "-" :quit-key "q" :title (concat (nerd-icons-mdicon "nf-md-language_ruby") " Ruby commands"))
             (,@heads)))))
