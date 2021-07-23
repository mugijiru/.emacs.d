+++
title = "ox-hugo"
draft = false
weight = 12
+++

## 概要 {#概要}

[ox-hugo](https://ox-hugo.scripter.co/) は org-mode から Hugo 用に md ファイルを出力できる便利なやつ。

設定にもよるけど、1つのorgファイルに全部の記事を書いておいてツリー毎に md ファイルが生成される、というのがデフォルトの動きなので
1ファイルに詰めておくとファイルが分散しないで済んで良い。

なお、この [麦汁's Emacs Config](./.org) も親サイトである [麦汁三昧](https://mugijiru.github.io/.emacs.d/) も
ox-hugo を用いて構築している


## インストール・読み込み {#インストール-読み込み}

いつも通り el-get でインスコしている。

```emacs-lisp
(el-get-bundle ox-hugo)
```

そして org-mode の ox が先に読まれてないといけないので
with-eval-after-load を使って、ox が読まれてから require するようにしている。

```emacs-lisp
(with-eval-after-load 'ox
  (require 'ox-hugo))
```


## その他 {#その他}

デフォルト設定でいい感じに使えているので特に設定変更は加えていない。
