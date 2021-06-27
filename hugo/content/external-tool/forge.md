+++
title = "forge"
draft = false
+++

## 概要 {#概要}

[forge](https://github.com/magit/forge) は magit と github を連携させるやつ。一応入れているけど実は使えてないのであまりこの設定を呼んでも意味はなさそう


## インストール {#インストール}

いつも通り el-get でインストール

```emacs-lisp
(el-get-bundle forge)
```


## 読み込み {#読み込み}

magit の拡張なので magit を読み込んで後に読み込まれるようにしている

```emacs-lisp
(with-eval-after-load 'magit
  (require 'forge))
```


## その他 {#その他}

リポジトリのコミット数が多いとまともに使えない感じだけどどうしたらいいの。
