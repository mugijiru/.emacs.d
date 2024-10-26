(el-get-bundle rbenv)

(global-rbenv-mode)

(el-get-bundle bundler)

(el-get-bundle yard-mode)

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
  (yard-mode 1)
  (eldoc-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode 1))

(add-hook 'enh-ruby-mode-hook 'my/ruby-modes-hook)

(add-hook 'ruby-ts-mode-hook 'my/ruby-modes-hook)

(add-to-list 'context-skk-programming-mode 'enh-ruby-mode)

(add-to-list 'context-skk-programming-mode 'ruby-ts-mode)

(with-eval-after-load 'major-mode-hydra
  (let ((heads '("Ruby"
                 (("{" enh-ruby-toggle-block "Toggle block")
                  ("e" enh-ruby-insert-end   "Insert end"))

                 "RSpec"
                 (("s" rspec-verify          "Run associated spec")
                  ("m" rspec-verify-method   "Run method spec")
                  ("r" rspec-rerun           "Rerun")
                  ("l" rspec-run-last-failed "Run last failed"))

                 "REPL"
                 (("I" inf-ruby "inf-ruby"))

                 "Other"
                 (("j" dumb-jump-go       "Dumb Jump")
                  ("o" origami-hydra/body "Origami")))))
    (eval `(major-mode-hydra-define enh-ruby-mode (:separator "-" :quit-key "q" :title (concat (nerd-icons-mdicon "nf-md-language_ruby") " Ruby commands"))
             (,@heads)))
    (eval `(major-mode-hydra-define ruby-ts-mode  (:separator "-" :quit-key "q" :title (concat (nerd-icons-mdicon "nf-md-language_ruby") " Ruby commands"))
             (,@heads)))))
