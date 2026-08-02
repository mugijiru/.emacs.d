(el-get-bundle copilot)

;; (add-hook 'prog-mode-hook 'copilot-mode)

(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))

(with-eval-after-load 'copilot
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "M-f") 'copilot-accept-completion-by-word)
  (define-key copilot-completion-map (kbd "M-n") 'copilot-next-completion)
  (define-key copilot-completion-map (kbd "M-p") 'copilot-previous-completion))

(setopt copilot-max-char-warning-disable t)

(setopt copilot-indent-offset-warning-disable t)

(el-get-bundle copilot-chat)

(setopt gh-copilot-chat-frontend 'org)

(with-eval-after-load 'copilot-chat-prompts
  (setq my/gh-copilot-chat-org-prompt-original gh-copilot-chat-org-prompt)
  (setopt gh-copilot-chat-org-prompt (concat my/gh-copilot-chat-org-prompt-original "\n出力には日本語を用います"))

  (setq my/gh-copilot-chat-markdown-prompt-original gh-copilot-chat-markdown-prompt)
  (setopt gh-copilot-chat-markdown-prompt (concat my/gh-copilot-chat-markdown-prompt-original "\n出力には日本語を用います"))

  (setq my/gh-copilot-chat-commit-prompt-original gh-copilot-chat-commit-prompt)
  (setopt gh-copilot-chat-commit-prompt (concat "description には英語 body には日本語を用いる。また1行は66文字以内に収めること。ただし日本語は1文字を2文字換算とする\n" my/gh-copilot-chat-commit-prompt-original)))

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define copilot-chat-hydra
    (:separator "-" :color teal :foreign-key warn :title (concat (nerd-icons-mdicon "nf-md-robot") " Copilot Chat") :quit-key "q")
    ("Launch"
     (("c" gh-copilot-chat-display             "Chat")
      ("S" gh-copilot-chat-switch-to-buffer    "Switch")
      ("d" gh-copilot-chat-doc                 "Doc")
      ("r" gh-copilot-chat-review-whole-buffer "Review")
      ("f" gh-copilot-chat-fix                 "Fix")
      ("C" gh-copilot-chat-ask-and-insert      "Insert")
      ("o" gh-copilot-chat-optimize            "Optimize")
      ("t" gh-copilot-chat-test                "Write test"))
     "Explain"
     (("e" gh-copilot-chat-explain                "Selected")
      ("s" gh-copilot-chat-explain-symbol-at-line "Symbol at line")
      ("f" gh-copilot-chat-explain-defun          "Function"))
     "Commit message"
     (("I" gh-copilot-chat-insert-commit-message "Insert")))))

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define copilot-chat-org-prompt-mode (:separator "-" :quit-key "q" :title (concat (nerd-icons-mdicon "nf-md-robot") " Copilot Chat Org Prompt"))
    ("Common"
     (("m" gh-copilot-chat-transient "Menu"))))
  (major-mode-hydra-define copilot-chat-markdown-prompt-mode (:separator "-" :quit-key "q" :title (concat (nerd-icons-mdicon "nf-md-robot") " Copilot Chat Markdown Prompt"))
    ("Common"
     (("m" gh-copilot-chat-transient "Menu"))))
  (major-mode-hydra-define copilot-chat-shell-mode (:separator "-" :quit-key "q" :title (concat (nerd-icons-mdicon "nf-md-robot") " Copilot Chat Shell Prompt"))
    ("Common"
     (("m" gh-copilot-chat-transient "Menu")))))
