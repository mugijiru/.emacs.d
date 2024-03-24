+++
title = "blamer.el"
draft = false
+++

## 概要 {#概要}

[blamer.el](https://github.com/Artawower/blamer.el) は VS code の Git Lens プラグインのようにその行の最後のコミット情報を表示してくれるやつ。

blamer-mode をオンにすると横の方に1行内で表示するが
posframe で overlay 表示させることもできる


## インストール {#インストール}

el-get 本体にはレシピがないので自前で用意している

```emacs-lisp
(:name blamer
       :website "https://github.com/Artawower/blamer.el"
       :description "A git blame plugin for emacs inspired by VS Code’s GitLens plugin and Vim plugin"
       :type github
       :branch "master"
       :pkgname "Artawower/blamer.el")
```

そしてそれを `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle blamer)
```


## 設定 {#設定}

`blame-show-posframe-commit-info` の際に上でも下でも適当な位置に表示してくれるように
smart 表示を指定している

```emacs-lisp
(setopt blammer--overlay-popup-position 'smart)
```


## その他 {#その他}

普段は表示されると邪魔そうなので今のところオフのままにしているが
[Hydra による Toggle Switches]({{< relref "hydra#toggle-switches" >}}) で切り替え可能にしている。

またより細かい情報を手軽に見られるようにするために
posframe でコミット情報を表示するコマンドを [jk で起動する Hydra]({{< relref "hydra#main" >}}) に設定している。
