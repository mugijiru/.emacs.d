+++
title = "git-messenger"
draft = false
+++

## 概要 {#概要}

[git-messenger](https://github.com/emacsorphanage/git-messenger) は指定した行のコミット時の情報を表示してくれるやつ簡単に最終コミットの情報を見るのに便利


## インストール {#インストール}

git-messenger は el-get のレシピに登録されているのでそのまま `el-get-bundle` を使ってインストールできる

```emacs-lisp
(el-get-bundle git-messenger)
```


## 設定 {#設定}

デフォルトでは commit message だけを表示するがより詳細な情報を見たいので `git-messenger:show-detail` を t に設定してコミット日時や author も表示するようにしている

```emacs-lisp
(custom-set-variables
 '(git-messenger:show-detail t))
```

magit を利用しているので `git-messenger:use-magit-popup` も有効にしても良いかもしれない


## キーバインド {#キーバインド}

起動には [pretty-hydra-usefull-commands]({{< relref "hydra#main" >}}) で `C` を叩くと起動するようにしている。

起動後は、デフォルトでキーバインドが定義されているので
<https://github.com/emacsorphanage/git-messenger#key-bindings>
の通りの操作ができる
