+++
title = "google-translate"
draft = false
+++

## 概要 {#概要}

[google-translate](https://github.com/atykhonov/google-translate) は Google 翻訳する機能を提供するパッケージ。


## インストール {#インストール}

いつも通り el-get でインストール

```emacs-lisp
(el-get-bundle google-translate)
```


## 関数のオーバーライド {#関数のオーバーライド}

どうも最新版でも壊れっぱなしのようなので
<https://github.com/atykhonov/google-translate/issues/52#issuecomment-727920888>
にあるように関数を上書きしている。

```emacs-lisp
(with-eval-after-load 'google-translate-tk
  (defun google-translate--search-tkk ()
    "Search TKK."
    (list 430675 2721866130)))
```

google-translate-tk に定義されていて、それが読まれた後に上書きしないといけないので
with-eval-after-load を使っている。


## default-ui の読み込み {#default-ui-の読み込み}

Google Translate は UI を defauult と smooth のどちらかから選べるようになっている。

default だと

-   `google-translate-default-source-language`
-   `google-translate-default-target-language`

を設定しておいて

`M-x google-translate-at-point`
: source → target の翻訳

`M-x google-translate-at-point-reverse`
: target → source の翻訳

という使い方をする。

smooth だと翻訳の source, target を複数設定して多言語対応ができるが、英語以外を翻訳することがないので smooth でなくていいかという感じで default を採用している。

```emacs-lisp
(with-eval-after-load 'popup
  (require 'google-translate-default-ui))
```

popup.el に依存しているのでそれが読まれた後に require しないといけなかった。というわけで with-eval-after-load で対応している。


## カスタム変数の設定 {#カスタム変数の設定}

上述の通り default UI を使うことにしたのでその変数をいくらか設定している。

```emacs-lisp
(custom-set-variables
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja")
 '(google-translate-output-destination 'popup))
```

google-translate-default-source-language
: 翻訳元言語

google-translate-default-target-language
: 翻訳先言語

google-translate-output-destination
: 翻訳結果の表示

日本語を母国語としていて英語はからきしという人間なので当然英日変換されるように設定していてあとは変換結果の表示方法は popup でツールチップ表示するようにしている。

popup 表示の欠点としては、その結果をコピペできないところだけど
current-buffer への挿入も邪魔そうだし
kill-ring に入れるのも違うしなどを考えた結果、消去法でこれにしてみた。

```emacs-lisp
(my/google-translate-at-point-output-tempbuf ()
  (let ((google-translate-output-destination nil))
    (google-translate-at-point)))
```

とか用意しておいたらその時だけデフォルト動作の temporary buffer への出力ができそうだけどもね。ただこれだと逆版も作らないといけなさそうなのでちょっと方法考えるか。別で output destination を切り替えるようにするとか。
