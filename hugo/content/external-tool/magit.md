+++
title = "magit"
draft = false
+++

## 概要 {#概要}

[magit](https://github.com/magit/magit) は Emacs の上で Git の色々な操作ができるやつ。結構使いやすいのでオススメなやつ。

[forge]({{< relref "forge" >}}) を使うと GitHub や GitLab とも連携できてさらに便利、なはず。


## インストール {#インストール}

```emacs-lisp
(el-get-bundle magit)
```


## 使い方 {#使い方}

Git 管理されてるファイルを開いている時に
`M-x magit` とかすると Git 管理用のバッファが出て来るしそこで `?` を叩いたらどういうコマンドが使えるのか教えてくれるよ(雑)
