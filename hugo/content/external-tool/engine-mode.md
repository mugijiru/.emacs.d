+++
title = "engine-mode"
draft = false
+++

## 概要 {#概要}

[engine-mode](https://github.com/hrs/engine-mode) は Emacs から様々な検索エンジンで検索するためのパッケージ
`defengine` というマクロを使ってエンジンを定義することで対応する検索エンジンを簡単に増やすことができる。デフォルトでは特に何も定義されていないので自分で定義していく必要がある


### インストール {#インストール}

engine-mode は el-get でレシピを提供されていないので自前で用意している。

```emacs-lisp
(:name engine-mode
       :website "https://github.com/hrs/engine-mode"
       :description "Define and query search engines"
       :type github
       :pkgname "hrs/engine-mode")
```

そしてこれを `el-get-bundle` でインストールして有効化している。

```emacs-lisp
(el-get-bundle engine-mode)
(engine-mode 1)
```


### エンジン定義 {#エンジン定義}

前述したように自分で定義しないと何も検索ができない。とりあえず今は Ruby/Rails 系を少しだけ定義している

```emacs-lisp
(defengine rurema-3.1
  "https://rurema.clear-code.com/version:3.1/query:%s/")

(defengine rurema-3.2
  "https://rurema.clear-code.com/version:3.2/query:%s/")

(defengine rurema-3.3
  "https://rurema.clear-code.com/version:3.3/query:%s/")

(defengine rails
  "https://apidock.com/rails/search?query=%s")

(defengine rspec
  "https://apidock.com/rspec/search?query=%s")
```


### その他の設定 {#その他の設定}

engine-mode はデフォルトだと `browse-url-browser-function` で結果を開くが
Emacs 内で完結する方が便利かもと思って今は [emacs-w3m]({{< relref "emacs-w3m" >}}) で検索結果ページを開くようにしている

```emacs-lisp
(setopt engine/browser-function 'w3m-browse-url)
```

なお検索結果は大体 emacs-w3m だとそのままではコンテンツ本体の前にメニューなどが表示されて邪魔くさいので
w3m-filter の機能を使ってそれらの表示を抑制している。

そのあたりは [emacs-w3m の設定ページ]({{< relref "emacs-w3m" >}}) に記述している
