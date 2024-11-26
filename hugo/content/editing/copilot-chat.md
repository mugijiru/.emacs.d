+++
title = "copilot-chat"
draft = false
+++

## 概要 {#概要}

[copilot-chat.el](https://github.com/chep/copilot-chat.el) は Emacs から GitHub Copilot Chat を使えるようにするパッケージ。


### インストール {#インストール}

el-get 本体にはレシピがないのと依存している各パッケージもレシピが古かったりするのでそれぞれ自前で用意している

```emacs-lisp
(:name shell-maker
       :website "https://github.com/xenodium/shell-maker"
       :description "shell-maker is a convenience wrapper around comint mode."
       :type github
       :pkgname "xenodium/shell-maker"
       :minimum-emacs-version "27.1")
```

```emacs-lisp
(:name chatgpt-shell
       :description "Interaction mode for ChatGPT"
       :type github
       :pkgname "xenodium/chatgpt-shell"
       :minimum-emacs-version "28.1"
       :depends (shell-maker))
```

```emacs-lisp
(:name copilot-chat
       :website "https://github.com/chep/copilot-chat.el"
       :description "This plugin allows you to chat with github copilot."
       :type github
       :pkgname "chep/copilot-chat.el"
       :depends (request markdown-mode chatgpt-shell magit))
```

そして `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle copilot-chat)
```


### 最初の起動 {#最初の起動}

とりあえず `M-x copilot-chat-display` で起動する。

最初の起動の時は適当なメッセージを `C-c C-c` で送信すると
GitHub Copilot Chat を有効にするための認証コードとメッセージが minibuffer に表示されるのでその認証コードをコピーして Enter を叩いたら Web ブラウザに認証コードを入れる画面が表示されるのであとは画面に従って動かしましょう


### その他 {#その他}

今のところ特に設定もキーバインドも弄っていない。とりあえずしばらく触りつつそのあたりは考えていく。

とはいえ defcustom できる変数は多くないけどね。
