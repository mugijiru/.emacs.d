+++
title = "yasnippet"
draft = false
+++

## 概要 {#概要}

[yasnippet](https://github.com/joaotavora/yasnippet) はテンプレートを挿入する機能を持ったパッケージ。
Emacs でそこそこ何かを書いている人なら大体知ってるような有名なやつだと思う。


## インストール {#インストール}

いつも通り el-get でインストール

```emacs-lisp
(el-get-bundle yasnippet)
```


## 有効化 {#有効化}

どこでも使いたいぐらい便利なやつなので global に有効化している

```emacs-lisp
(yas-global-mode 1)
```


## キーバインド {#キーバインド}

基本的に覚えられないので Hydra を使って定義している

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define
    yasnippet-hydra (:separator "-" :title "Yasnippet" :foreign-key warn :quit-key "q" :exit t)
    ("Edit"
     (("n" yas-new-snippet        "New")
      ("v" yas-visit-snippet-file "Visit"))

     "Other"
     (("i" yas-insert-snippet  "Insert")
      ("l" yas-describe-tables "List")
      ("r" yas-reload-all      "Reload all")))))
```

| Key | 効果                           |
|-----|------------------------------|
| n   | 現在のメジャーモード用に新しい snippet を作る |
| v   | 現在のメジャーモードの登録済 snippet ファイルを開く |
| i   | snippet の挿入。選択は ivy で行われる。 |
| l   | 現在のメジャーモードの登録済 snippet の一覧表示 |
| r   | snippet を全部 load し直す     |


## その他 {#その他}

実は、どういう snippet があれば便利なのかよくわかってなくて
snippet をほとんど登録してない。

[yasnippet-snippets](https://github.com/AndreaCrotti/yasnippet-snippets) などのよくある snippet 集は、そんなの省略形をまず覚えられないだろと思っている。
ivy で選択可能なので省略形は長くていいので中身がわかりやすい方が良い。

また導入はしてないが [ivy-yasnippet](https://github.com/mkcms/ivy-yasnippet) を入れるとさらにそのあたりがやりやすくなるんじゃないかと思う。

それから company-yasnippet で補完できるようにしているとより良いかもれない。

とはいえ snippet を充実させてない今だとどうにもイマイチそのあたりを充実させる気力がない
