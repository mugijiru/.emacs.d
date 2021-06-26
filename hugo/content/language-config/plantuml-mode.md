+++
title = "plantuml-mode"
draft = false
+++

## 概要 {#概要}

[plantuml-mode](https://github.com/skuro/plantuml-mode) は [PlantUML](https://plantuml.com/ja/) という、テキストだけで UML 図などが描けるツール用のモード。


## インストール {#インストール}

いつも通り el-get で入れてる

```emacs-lisp
(el-get-bundle plantuml-mode)
```


## 設定 {#設定}

実行モードは `'jar` を指定している。デフォルトは `'server` なんだけどオフラインの時も使いたいししね。

```emacs-lisp
(setq plantuml-default-exec-mode 'jar)
```

el-get でインスコすると jar ファイルも自動で拾って来て
plantuml-mode と同じディレクトリに設置して
`plantuml-jar-path` も通してくれるからそっち使う方が便利だしね。


## その他 {#その他}

最新の develop ブランチだとインデントを調整できる機能が入っているので乗り換えたいけどそのためには el-get のレシピを書いてあげる必要がありそうで放置している。
