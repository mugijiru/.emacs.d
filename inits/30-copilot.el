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

(setopt copilot-chat-frontend 'org)

(with-eval-after-load 'copilot-chat-common
  (setopt copilot-chat-prompt-suffix "\n出力には日本語を用います"))

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define copilot-chat-hydra
    (:separator "-" :color teal :foreign-key warn :title (concat (nerd-icons-mdicon "nf-md-robot") " Copilot Chat") :quit-key "q")
    ("Launch"
     (("c" copilot-chat-display             "Chat")
      ("S" copilot-chat-switch-to-buffer    "Switch")
      ("d" copilot-chat-doc                 "Doc")
      ("r" copilot-chat-review-whole-buffer "Review")
      ("f" copilot-chat-fix                 "Fix")
      ("C" copilot-chat-ask-and-insert      "Insert")
      ("o" copilot-chat-optimize            "Optimize")
      ("t" copilot-chat-test                "Write test"))
     "Explain"
     (("e" copilot-chat-explain                "Selected")
      ("s" copilot-chat-explain-symbol-at-line "Symbol at line")
      ("f" copilot-chat-explain-defun          "Function"))
     "Commit message"
     (("I" copilot-chat-insert-commit-message "Insert")))))

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define copilot-chat-org-prompt-mode (:separator "-" :quit-key "q" :title (concat (nerd-icons-mdicon "nf-md-robot") " Copilot Chat Org Prompt"))
    ("Common"
     (("m" copilot-chat-transient "Menu"))))
  (major-mode-hydra-define copilot-chat-markdown-prompt-mode (:separator "-" :quit-key "q" :title (concat (nerd-icons-mdicon "nf-md-robot") " Copilot Chat Markdown Prompt"))
    ("Common"
     (("m" copilot-chat-transient "Menu"))))
  (major-mode-hydra-define copilot-chat-shell-mode (:separator "-" :quit-key "q" :title (concat (nerd-icons-mdicon "nf-md-robot") " Copilot Chat Shell Prompt"))
    ("Common"
     (("m" copilot-chat-transient "Menu")))))
