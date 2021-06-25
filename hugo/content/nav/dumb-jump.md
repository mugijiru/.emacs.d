+++
title = "dumb-jump"
draft = false
+++

## 概要 {#概要}

[dumb-jump](https://github.com/jacktasia/dumb-jump) は関数とかの定義されてる場所にお手軽にジャンプできるようにするパッケージ。めっちゃ色々な言語をサポートしている。


## インストール {#インストール}

いつも通り el-get でインストールしている。

```emacs-lisp
(el-get-bundle dumb-jump)
```


## 設定 {#設定}


### デフォルトプロジェクトの変更 {#デフォルトプロジェクトの変更}

デフォルトだと `~/` がデフォルトプロジェクトらしいがそんなに上の階層から調べられてもしょうがない気がするのでソースコードを置いているフォルダを指定している。

```emacs-lisp
(setq dumb-jump-default-project "~/projects")
```


### 複数マッチした時に使う絞り込み {#複数マッチした時に使う絞り込み}

最近はできるだけ ivy を使うようにしているので
dumb-jump でも ivy を使うように指定している。

```emacs-lisp
(setq dumb-jump-selector 'ivy)
```


## キーバインド {#キーバインド}

README に書いている hydra の設定をほぼパクってるけど
pretty-hydra を使ってキーを定義している

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define dumb-jump-pretty-hydra
    (:foreign-keys warn :title "Dumb jump" :quit-key "q" :color blue :separator "-")
    ("Go"
     (("j" dumb-jump-go "Jump")
      ("o" dumb-jump-go-other-window "Other window"))

     "External"
     (("e" dumb-jump-go-prefer-external "Go external")
      ("x" dumb-jump-go-prefer-external-other-window "Go external other window"))

     "Lock"
     (("l" dumb-jump-quick-look "Quick look"))

     "Other"
     (("b" dumb-jump-back "Back")))))
```

| Key | 効果                                        |
|-----|-------------------------------------------|
| j   | 定義場所にジャンプ                          |
| o   | 定義場所を別 window で開く                  |
| e   | 定義場所にジャンプ。ただし同じファイルより外部ファイルとのマッチを優先 |
| x   | 定義場所を別 window で開く。ただし同じファイルより外部ファイルとのマッチを優先 |
| l   | クイックルック。定義をツールチップ表示する  |
| b   | 最後にジャンプされた場所に戻る。今は既に obsolute 扱い |
