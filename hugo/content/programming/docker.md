+++
title = "Docker"
draft = false
+++

## 概要 {#概要}

Dockerfile を書いたりするための設定。ちゃんと設定したら Emacs から Docker の操作もできるようだけどそこまでは対応してない


## dockerfile-mode {#dockerfile-mode}


### インストール {#インストール}

こちらは el-get にレシピが登録されているので単純に `el-get-bundle` でインストールしている。

```emacs-lisp
(el-get-bundle dockerfile-mode)
```


### カスタマイズ {#カスタマイズ}

とりあえずインデントはスペース 2 つで普段書いているのでそれに合わせてカスタム変数を指定している。

```emacs-lisp
(custom-set-variables
 '(dockerfile-indent-offset 2))
```


### hook {#hook}

[lsp-mode では Dockerfile もサポートしている](https://emacs-lsp.github.io/lsp-mode/page/lsp-dockerfile/) ので

```text
$ npm install -g dockerfile-language-server-nodejs
```

で LSP サーバを入れた上で
dockerfile-mode-hook で lsp を起動させるようにしている。

あとついでに display-line-numbers-mode も有効にしている。

```emacs-lisp
(defun my/dockerfile-mode-hook ()
  (display-line-numbers-mode t)
  (lsp))

(add-hook 'dockerfile-mode-hook 'my/dockerfile-mode-hook)
```
