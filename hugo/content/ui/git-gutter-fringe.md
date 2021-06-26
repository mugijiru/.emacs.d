+++
title = "git-gutter-fringe"
tags = ["improvement"]
draft = false
+++

## 概要 {#概要}

[git-gutter-fringe](https://github.com/emacsorphanage/git-gutter-fringe) は [git-gutter](https://github.com/emacsorphanage/git-gutter) の派生版。最後のコミットからどの行を弄ったかを fringe 領域に表示してくれる。

他にも hunk の操作をできる機能とかあるみたいだけどそのあたりは使ったことがない……。

派生元の git-gutter は linum-mode と同じ領域を使って描画をしているようで併用ができなかったので git-gutter-fringe を利用している。

が、Emacs 26 から display-line-numbers-mode が搭載されて linum-mode が不要になったので
git-gutter に乗り換えても良さそう


## インストール {#インストール}

いつも通り el-get でインストールしている

```emacs-lisp
(el-get-bundle git-gutter-fringe)
```


## 有効化 {#有効化}

Git 管理しているやつは全部差分情報が表示されて欲しいのでグローバルマイナーモードを有効にしている。

```emacs-lisp
(global-git-gutter-mode t)
```


## その他 {#その他}

git-gutter ほどではないけど多少のカスタマイズはできるはずだがデフォルト設定で特に不満はないので何もしてない
