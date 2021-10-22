+++
title = "ddskk"
draft = false
+++

## 概要 {#概要}

[ddskk](http://openlab.ring.gr.jp/skk/ddskk-ja.html) は Emacs Lisp 版の SKK 実装。

一般的な日本語変換ソフトだと文法を自動で認識して変換をしてくれるけど
SKK ではその自動認識がおかしくておかしな変換になるところを、単語の区切りなんかを一切判定せずに人間がそれを教えてあげることで、そういう自動的に変な挙動をしてしまう煩わしさから開放されるようになっている。


## インストール {#インストール}

いつも通り el-get で入れている。最近は最新版が GitHub で更新されているのでそちらから引っ張られてくる。

```emacs-lisp
(el-get-bundle ddskk)
```


## hook の設定 {#hook-の設定}

ddskk が呼び出された時に色々設定されるようにしている。

もしかしたら customize-variable とかあるかもしれないので今度見直した方が良さそう。

```emacs-lisp
(add-hook 'skk-load-hook
          (lambda ()
            ;; コード中では自動的に英字にする。
            (require 'context-skk)

            (setq skk-comp-mode t) ;; 動的自動補完
            (setq skk-auto-insert-paren t)
            (setq skk-delete-implies-kakutei nil)
            (setq skk-sticky-key ";")
            (setq skk-henkan-strict-okuri-precedence t)
            (setq skk-show-annotation t) ;; 単語の意味をアノテーションとして表示。例) いぜん /以前;previous/依然;still/

            ;; ;; 半角で入力したい文字
            ;; (setq skk-rom-kana-rule-list
            ;;       (nconc skk-rom-kana-rule-list
            ;;              '((";" nil nil)
            ;;                (":" nil nil)
            ;;                ("?" nil nil)
            ;;                ("!" nil nil))))
            ))
```

skk-comp-mode
: 自動補完関係らしいが、ググっても出て来ないし死んだ設定かもしれない

skk-auto-insert-paren
: カッコを入力するとコッカも入れてくれる便利機能の切替

skk-delete-implies-kakutei
: nil にすると▼モードで <BS> を押した時 に一つ前の候補を表示するようになる

skk-sticky-key
: 設定すると、その指定したキーを押した時に変換開始状態などにする Sticky Shift を提供する

skk-henkan-strict-okuri-precedence
: 正しい送り仮名の変換が優先的に表示されるようにする設定

skk-show-annotation
: 単語の意味をアノテーションとして表示する設定

skk-rom-kana-rules-list
: キー入力時の挙動を指定する。とりあえず自分は : とかが全角になるのが嫌なので半角になるようにしている


## 辞書ファイルの指定 {#辞書ファイルの指定}

共有辞書や個人辞書以外の追加辞書を指定している。が、このマシンではそんなところに辞書置いてないな……。見直しの必要あり

```emacs-lisp
(setq skk-extra-jisyo-file-list (list '("~/.emacs.d/skk-jisyo/SKK-JISYO.lisp" . japanese-iso-8bit-unix)))
```


## AquaSKK の L 辞書を使うようにする {#aquaskk-の-l-辞書を使うようにする}

これはもう Mac 用の設定ですね。

```emacs-lisp
(let ((l-dict (expand-file-name "~/Library/Application Support/AquaSKK/SKK-JISYO.L")))
  (if (file-exists-p l-dict)
      (setq skk-large-jisyo l-dict)))
```

WSL で動かしている Emacs では
CurvusSKK の辞書を見るように設定した方が良さそう。

そう、WSL2 では L 辞書が使えなくて変換がちょっとだるいけど放置しているのである!
なのでそういう意味で見直しが必要。


## ddskk-posframe {#ddskk-posframe}

[ddskk-posframe](https://github.com/conao3/ddskk-posframe.el/) は ddskk ツールチップを posframe で表示してくれるやつ。便利。

<https://emacs-jp.github.io/packages/ddskk-posframe>
に作った本人が解説記事を日本語で載せてるので詳細はそっちを見てもらう方が早い。

とりあえず以下でインストール、有効化している。

```emacs-lisp
(el-get-bundle conao3/ddskk-posframe.el)
(ddskk-posframe-mode 1)
```


## その他 {#その他}

漢字の変換すらも機械任せではなく自分で決めるみたいな漢字直接入力という方式もあり、
SKK とそれを組み合わせると入力キーを覚えている漢字は漢直で入力しそうでない漢字は SKK で入力する、といった使い分けができるらしい。

特に同音意義語が多い場合に便利そう。
