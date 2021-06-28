+++
title = "Google 連携"
draft = false
+++

## 概要 {#概要}

Google と連携するパッケージとして
[google-this]({{< relref "google-this" >}}) と [google-translate]({{< relref "google-translate" >}}) を入れているが、どっちも Google を使うので1つの Hydra にまとめていた方が扱いやすいと思って統合している


## キーバインド {#キーバインド}

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define google-pretty-hydra
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
     (("L" google-this-lucky-search         "Lucky")
      ("i" google-this-lucky-and-insert-url "Insert URL"))

     "Translate"
     (("t" google-translate-at-point         "EN => JP")
      ("T" google-translate-at-point-reverse "JP => EN"))

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
| t   | 英語→日本語翻訳                       |
| T   | 日本語→英語翻訳                       |
| w   | 天気を調べる                          |
