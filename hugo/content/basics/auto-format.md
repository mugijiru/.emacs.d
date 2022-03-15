+++
title = "auto-format"
draft = false
+++

## 概要 {#概要}

保存時に自動で整形してくれるように
[fork した auto-fix.el](https://github.com/mugijiru/auto-fix.el) を使っている。

これを入れて各 major-mode で設定をするとファイル保存時に自動で整形してくれて便利だったりする


## インストール {#インストール}

fork しているので自前で recipe も用意している

```emacs-lisp
(:name auto-fix
       :website "https://github.com/mugijiru/auto-fix.el"
       :description "Fix current buffer automatically"
       :type github
       :branch "accept-multiple-args"
       :pkgname "mugijiru/auto-fix.el")
```

これを以下のようにして el-get でインスコしている

```emacs-lisp
(el-get-bundle auto-fix)
```
