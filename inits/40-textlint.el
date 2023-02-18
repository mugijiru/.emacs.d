(custom-set-variables
  '(flycheck-textlint-config "~/.config/textlint/textlintrc_ja.json"))

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'textlint 'forge-post-mode))
