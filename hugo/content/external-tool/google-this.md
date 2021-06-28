+++
title = "google-this"
draft = false
+++

## 概要 {#概要}

[google-this](https://github.com/Malabarba/emacs-google-this) は Google 検索を Emacs の中から行えるやつ。


## インストール {#インストール}

いつも通り el-get でインストール

```emacs-lisp
(el-get-bundle google-this)
```

で、本来の使い方だとこのあとに

```emacs-lisp
(google-this-mode 1)
```

とやって有効化することになるがそれをしても google-this のデフォルトキーバインドが設定されるぐらいで自分はそのデフォルトキーバインドを使う気がないので有効化はしてない。


## キーバインド {#キーバインド}

キーバインドは Hydra で設定しているが、
[google-translate]({{< relref "google-translate" >}}) と統合したので
[キーバインド > Google 連携]({{< relref "google-integration" >}}) に記載している。
