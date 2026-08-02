+++
title = "copilot-chat"
draft = false
+++

## 概要 {#概要}

[copilot-chat.el](https://github.com/chep/copilot-chat.el) は Emacs から GitHub Copilot Chat を使えるようにするパッケージ。


## インストール {#インストール}

el-get 本体にはレシピがないので自前で用意している。なお依存している [shell-maker](https://github.com/xenodium/shell-maker) などのレシピは [chatgpt-shell の設定ページ]({{< relref "chatgpt-shell" >}}) に置いてある

```emacs-lisp
(:name copilot-chat
       :website "https://github.com/chep/copilot-chat.el"
       :description "This plugin allows you to chat with github copilot."
       :type github
       :pkgname "chep/copilot-chat.el"
       :depends (request markdown-mode magit transient org-mode polymode shell-maker mcp))
```

依存関係にある mcp.el のレシピも追加している

```emacs-lisp
(:name mcp
       :website "https://github.com/lizqwerscott/mcp.el"
       :description "Model Context Protocol for Emacs"
       :type github
       :pkgname "lizqwerscott/mcp.el")
```

そして `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle copilot-chat)
```


## 最初の起動 {#最初の起動}

とりあえず `M-x copilot-chat-display` で起動する。

最初の起動の時は適当なメッセージを `C-c C-c` で送信すると
GitHub Copilot Chat を有効にするための認証コードとメッセージが minibuffer に表示されるのでその認証コードをコピーして Enter を叩いたら Web ブラウザに認証コードを入れる画面が表示されるのであとは画面に従って動かしましょう


## 設定 {#設定}

色々使っていると frontend は `shell-maker` の方が使いやすいっぽいのでそれを指定している

```emacs-lisp
(setopt gh-copilot-chat-frontend 'org)
```

また出力は日本語の方が日本人には嬉しいのでひとまず `copilot-chat-org-prompt` 及び `copilot-chat-markdown-prompt` の末尾に日本語を出力するように指定している。またコミットメッセージの生成もカスタマイズしている。

その際 `copilot-chat-common` の読み込み後に設定しないと変数がないというエラーになるので
`with-eval-after-load` の中に閉じ込めている。まあこのエラーになる問題は 2025/03 の本体のリファクタで解消しているかもしれないけど。

```emacs-lisp
(with-eval-after-load 'copilot-chat-prompts
  (setq my/gh-copilot-chat-org-prompt-original gh-copilot-chat-org-prompt)
  (setopt gh-copilot-chat-org-prompt (concat my/gh-copilot-chat-org-prompt-original "\n出力には日本語を用います"))

  (setq my/gh-copilot-chat-markdown-prompt-original gh-copilot-chat-markdown-prompt)
  (setopt gh-copilot-chat-markdown-prompt (concat my/gh-copilot-chat-markdown-prompt-original "\n出力には日本語を用います"))

  (setq my/gh-copilot-chat-commit-prompt-original gh-copilot-chat-commit-prompt)
  (setopt gh-copilot-chat-commit-prompt (concat "description には英語 body には日本語を用いる。また1行は66文字以内に収めること。ただし日本語は1文字を2文字換算とする\n" my/gh-copilot-chat-commit-prompt-original)))
```


## キーバインド {#キーバインド}

色々な起動コマンドがあるので `pretty-hydra` を使って Hydra の定義をしてる。使うのは偏るかもしれないけど、とりあえずこれで行ってみる

```emacs-lisp
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
```

transient も標準で定義されているのでそれを各 prompt-mode で [major-mode-hydra]({{< relref "init.md#major-mode-hydra-のインストール" >}}) 経由で起動できるようにしている。

```emacs-lisp
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
```

まあ pretty-hydra で定義されているやつを移植したりしても良さそうだけど一旦ミニマムに対応。頑張るのも面倒なので。
