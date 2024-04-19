+++
title = "minimap"
draft = false
+++

## 概要 {#概要}

[minimap](https://github.com/dengste/minimap) はソースコード全体を縮小表示してくれるので全体を俯瞰するのに便利なやつです


## インストール {#インストール}

el-get 本体にレシピが存在するのでそのまま `el-get-bundle` で入れています

```emacs-lisp
(el-get-bundle minimap)
```


## 設定 {#設定}


### 表示位置 {#表示位置}

デフォルト設定は左側への表示ですが右側に表示したいので表示位置を指定しています

```emacs-lisp
(setopt minimap-window-location 'right)
```
