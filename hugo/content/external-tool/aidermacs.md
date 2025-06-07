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
  :depends (compat transient markdown-mode)
  :branch "main")
```

そして `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle aidermacs)
```


## 設定 {#設定}

今はひとまず Gemini を使っているので環境変数に Gemini や Groq, OpenRouter の API キーを設定してあとデフォルトで使うモデルの指定を行っている。まあモデルはプロジェクト内の .aider.conf.yml でも結局指定するんだけども

```emacs-lisp
(setenv "GEMINI_API_KEY"
        (funcall (plist-get (nth 0 (auth-source-search :host "gemini" :max 1)) :secret)))
(setenv "GROQ_API_KEY"
        (funcall (plist-get (nth 0 (auth-source-search :host "groqcloud" :max 1)) :secret)))
(setenv "OPENROUTER_API_KEY"
        (funcall (plist-get (nth 0 (auth-source-search :host "openrouter" :max 1)) :secret)))

(setopt aidermacs-default-model "gemini-2.5-pro")
```


## キーバインド {#キーバインド}

ひとまず major-mode-hydra で aidermacs の transient menu を表示できるようにしている。

```emacs-lisp
(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define aidermacs-comint-mode
    (:foreign-keys warn :title "Aidermacs" :quit-key "q" :color blue :separator "-")
    ("Common"
     (("m" aidermacs-transient-menu "Menu")))))
```

直接 transient menu を出せるとその方が良さそうだけど、今はこれでお茶を濁す
