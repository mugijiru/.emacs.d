+++
title = "copilot-chat"
draft = false
+++

## 概要 {#概要}

[copilot-chat.el](https://github.com/chep/copilot-chat.el) は Emacs から GitHub Copilot Chat を使えるようにするパッケージ。


### インストール {#インストール}

el-get 本体にはレシピがないので自前で用意している。なお依存している [chatgpt-shell](https://github.com/xenodium/chatgpt-shell) などのレシピは [chatgpt-shell の設定ページ]({{< relref "chatgpt-shell" >}}) に置いてある

```emacs-lisp
(:name copilot-chat
       :website "https://github.com/chep/copilot-chat.el"
       :description "This plugin allows you to chat with github copilot."
       :type github
       :pkgname "chep/copilot-chat.el"
       :depends (request markdown-mode magit transient org-mode polymode))
```

そして `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle copilot-chat)
```


### 最初の起動 {#最初の起動}

とりあえず `M-x copilot-chat-display` で起動する。

最初の起動の時は適当なメッセージを `C-c C-c` で送信すると
GitHub Copilot Chat を有効にするための認証コードとメッセージが minibuffer に表示されるのでその認証コードをコピーして Enter を叩いたら Web ブラウザに認証コードを入れる画面が表示されるのであとは画面に従って動かしましょう


### 設定 {#設定}

色々使っていると frontend は `shell-maker` の方が使いやすいっぽいのでそれを指定している

```emacs-lisp
(setopt copilot-chat-frontend 'org)
```

また出力は日本語の方が日本人には嬉しいのでひとまず `copilot-chat-prompt` の末尾に日本語を出力するように指定している。

その際 `copilot-chat-common` の読み込み後に設定しないと変数がないというエラーになるので
`with-eval-after-load` の中に閉じ込めている

```emacs-lisp
(with-eval-after-load 'copilot-chat-common
  (setq my/copilot-chat-prompt-original copilot-chat-prompt)
  (setopt copilot-chat-prompt (concat my/copilot-chat-prompt-original "\n出力には日本語を用います")))
```


### キーバインド {#キーバインド}

色々な起動コマンドがあるので `pretty-hydra` を使って Hydra の定義をしてる。使うのは偏るかもしれないけど、とりあえずこれで行ってみる

```emacs-lisp
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
```
