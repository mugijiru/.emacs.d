+++
title = "aidermacs"
draft = false
+++

## 概要 {#概要}

[aidermacs](https://github.com/MatthewZMD/aidermacs) は Emacs 上で [Aider](https://github.com/Aider-AI/aider) とやりとりするためのパッケージ。
Aider は AI ペアプロをするためのツールで、それとのやりとりを Emacs 上でできるようにしてくれるやつ


## インストール {#インストール}

el-get にはレシピがないので自前で用意している

```emacs-lisp
( :name aidermacs
  :website "https://github.com/MatthewZMD/aidermacs"
  :description "AI Pair Programming in Emacs"
  :type github
  :pkgname "MatthewZMD/aidermacs"
  :branch "main")
```

そして `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle aidermacs)
```


## 設定 {#設定}

今はひとまず Gemini を使っているので環境変数に Gemini の API キーをセットしつつモデルの指定を行っている

```emacs-lisp
(setenv "GEMINI_API_KEY"
        (funcall (plist-get (nth 0 (auth-source-search :host "gemini" :max 1)) :secret)))

(setopt aidermacs-default-model "gemini-2.5-pro")
```
