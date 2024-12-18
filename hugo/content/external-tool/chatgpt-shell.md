+++
title = "chatgpt-shell"
draft = false
+++

## 概要 {#概要}

[chatgpt-shell](https://github.com/xenodium/chatgpt-shell) は OpenAI の ChatGPT とか Google の Gemini とかとチャットできるようにするパッケージ


## インストール {#インストール}

el-get 本体にはレシピがないので自前で用意している。依存パッケージである [shell-maker](https://github.com/xenodium/shell-maker) のレシピも自前で用意している。

```emacs-lisp
(:name shell-maker
       :website "https://github.com/xenodium/shell-maker"
       :description "shell-maker is a convenience wrapper around comint mode."
       :type github
       :pkgname "xenodium/shell-maker"
       :branch "main"
       :minimum-emacs-version "27.1")
```

```emacs-lisp
(:name chatgpt-shell
       :description "Interaction mode for ChatGPT"
       :type github
       :pkgname "xenodium/chatgpt-shell"
       :branch "main"
       :minimum-emacs-version "28.1"
       :depends (shell-maker))
```

そして `el-get-bundle` でインストールしている。

```emacs-lisp
(el-get-bundle chatgpt-shell)
```


## 設定 {#設定}

とりあえず Gemini を指定した上で
authinfo に登録した API キーを引っ張り出して使っている

```emacs-lisp
(setopt chatgpt-shell-model-version "gemini-1.5-flash")
(setopt chatgpt-shell-google-key
        (funcall (plist-get (nth 0 (auth-source-search :host "gemini" :max 1)) :secret)))
```
