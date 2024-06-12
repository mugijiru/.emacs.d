+++
title = "mistty"
draft = false
+++

## 概要 {#概要}

[mistty](https://github.com/szermatt/mistty) は Emacs 上で動く terminal の一種。表示されるやつが全部編集可能らしい。便利げ。

ちょっと fzf とは相性が悪いっぽい。


## インストール {#インストール}

el-get 本体にレシピはないので自前で用意。

```emacs-lisp
(:name mistty
       :website "https://github.com/szermatt/mistty"
       :description "shell/comint alternative with a fully functional terminal"
       :type github
       :branch "master"
       :pkgname "szermatt/mistty")
```

そして `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle mistty)
```


## 設定 {#設定}

とりあえず普段 zsh を使っているのでそれで起動するように調整している。

```emacs-lisp
(setopt explicit-shell-file-name "/usr/bin/zsh")
```

なお mistty そのものは fish との相性が一番良いっぽい
