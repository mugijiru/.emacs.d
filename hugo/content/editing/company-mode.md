+++
title = "company-mode"
draft = false
+++

## 概要 {#概要}

[company-mode](https://github.com/company-mode/company-mode) は Emacs での補完機能を提供してくれるパッケージです。プラグイン式に拡張しやすいのが特徴っぽい。


## インストール {#インストール}

いつも透り el-get から入れている

```emacs-lisp
(el-get-bundle company-mode)
```


## 設定 {#設定}

ほとんど設定は入れていない。有効な時に `C-s` を入力すると検索ができる程度。

というのも最近の更新で、デフォルトが結構好みのキーバインドになったのでキーバインドはこだわる必要がなくなったのと、ついでに色もそこで好みな感じになってくれた。

というわけで設定は以下のようにとてもシンプル。

```emacs-lisp
(with-eval-after-load 'company
  ;; active
  (define-key company-active-map (kbd "C-s") 'company-search-candidates))
```


## その他 {#その他}

グローバルでは有効にしていなくて各モードで有効にするような hook を入れている。

グローバルで有効でもいい気がしている。
