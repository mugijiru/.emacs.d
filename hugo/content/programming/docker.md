+++
title = "Docker"
draft = false
+++

## 概要 {#概要}

Docker の管理をしたり Dockerfile を書いたりするための設定を書いている


## docker.el {#docker-dot-el}


### 概要 {#概要}

[docker.el](https://github.com/Silex/docker.el) は Docker のコンテナやらイメージやらを Emacs 上で管理するためのパッケージです。


### インストール {#インストール}

el-get 本体にレシピがあるので `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle docker)
```

設定は今のところ特に弄っていません。
transient が動くのでキーバインドも特に設定していません。


## dockerfile-mode {#dockerfile-mode}

[dockerfile-mode](https://github.com/spotify/dockerfile-mode) は Dockerfile を編集するためのメジャーモード


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
  (flycheck-mode 1)
  (lsp))

(add-hook 'dockerfile-mode-hook 'my/dockerfile-mode-hook)
(add-hook 'dockerfile-ts-mode-hook 'my/dockerfile-mode-hook)
```
