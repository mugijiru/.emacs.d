+++
title = "dmacro"
draft = false
+++

[dmacro](https://github.com/emacs-jp/dmacro) は繰り返した処理を自動的にマクロとして記録してくれるパッケージ。繰り返し同じような操作をする時に便利そうなので入れてみている。


## インストール {#インストール}

el-get 本体に登録されているレシピが古そうだったのでとりあえず GitHub から取得するレシピを定義している。

```emacs-lisp
(:name dmacro
 :website "https://github.com/emacs-jp/dmacro"
 :description "Repeated detection and execution of key operation."
 :type github
 :pkgname "emacs-jp/dmacro"
 :depends (cl-lib))
```

そしていつも通り `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle dmacro)
```


## 設定 {#設定}

super key は使ってないのでデフォルトのキーバインドから変更している

```emacs-lisp
(setopt dmacro-key (kbd "C-M-y"))
```


## 有効化 {#有効化}

とりあえずどこで動いても問題なさそうなので global に有効化している

```emacs-lisp
(global-dmacro-mode 1)
```
