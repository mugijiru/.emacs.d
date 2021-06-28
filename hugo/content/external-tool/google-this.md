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

キーバインドは Hydra で設定している

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define google-this-pretty-hydra
    (:foreign-keys warn :title "Google" :quit-key "q" :color blue :separator "-")
    ("Current"
     (("SPC" google-this-noconfirm "No Confirm")
      ("RET" google-this           "Auto")
      ("w"   google-this-word      "Word")
      ("l"   google-this-line      "Line")
      ("s"   google-this-symbol    "Symbol")
      ("r"   google-this-region    "Region")
      ("e"   google-this-error     "Error"))

     "Feeling Lucky"
     (("L"   google-this-lucky-search         "Lucky")
      ("i"   google-this-lucky-and-insert-url "Insert URL"))

     "Tool"
     (("W" google-this-forecast "Weather")))))
```

| Key | 効果                                  |
|-----|-------------------------------------|
| SPC | 確認なしで検索                        |
| RET | どの範囲の情報で検索するか自動判定して検索 |
| w   | 近くの単語で検索                      |
| l   | その行の内容で検索。エラーの検索とかに良いかも |
| s   | シンボルで検索。使うのは Emacs Lisp の関数調べる時ぐらいか? |
| r   | リージョンで検索。まあリージョン選択してたら RET とかでいいんだけども |
| e   | コンパイルバッファのエラーで検索するっぽい |
| L   | 1件目を開く                           |
| i   | 1件目の URL を挿入する                |
| w   | 天気を調べる                          |
