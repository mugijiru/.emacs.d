+++
title = "plantuml-mode"
draft = false
+++

## 概要 {#概要}

[plantuml-mode](https://github.com/skuro/plantuml-mode) は [PlantUML](https://plantuml.com/ja/) という、テキストだけで UML 図などが描けるツール用のモード。


## インストール {#インストール}

el-get のレシピは自前で用意。

```emacs-lisp
(:name plantuml-mode
       :description "Major mode for PlantUML."
       :type github
       :branch "develop"
       :pkgname "skuro/plantuml-mode"
       :post-init (let ((plantuml-url "http://sourceforge.net/projects/plantuml/files/plantuml.jar/download")
                        (plantuml-jar (expand-file-name "plantuml.jar" default-directory)))
                    (when (not (file-exists-p plantuml-jar))
                      (url-copy-file plantuml-url plantuml-jar)))
       :prepare (setq plantuml-jar-path
                      (expand-file-name "plantuml.jar" default-directory)))
```

そして el-get で入れてる

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
