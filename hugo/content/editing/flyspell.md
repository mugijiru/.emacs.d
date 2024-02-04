+++
title = "flyspell"
draft = false
+++

## 概要 {#概要}

[flyspell](http://www-sop.inria.fr/members/Manuel.Serrano/flyspell/flyspell.html) はスペルチェックをしてくれるパッケージです。
Emacs 本体に組込まれているので、設定すれば素の Emacs でも使えます。


## hunspell 向けの設定 {#hunspell-向けの設定}

flyspell は外部のスペルチェックツールとやりとりをします。私は hunspell を使ってるので、それ向けに設定をしています。

```emacs-lisp
;; for hunspell
(with-eval-after-load "ispell"
  (setenv "DICTIONARY" "en_US")
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
```

どうせ英語のスペルしかチェックしないので DICTIONARY には en_US を設定しています。また、日英が混在している文書でもスペルチェックが動くように
`ispell-skip-region-alist` を設定しています

<http://home.hatanaka.info/article/474728666.html>
を参考にしていますが、まあ多分 ASCII 以外をシカトしているのかなこれは


## incorrect-hook の定義 {#incorrect-hook-の定義}

上の設定でも ASCII 以外を無視してそうだけどさらに `flyspell-incorrect-hook` で incorrect 判定するのを ASCII にのみ限定しています。

```emacs-lisp
;; Original: https://takaxp.github.io/init.html#orgdd65fc08
(defun my/flyspell-ignore-nonascii (beg end _info)
  "incorrect判定をASCIIに限定"
  (string-match "[^!-~]" (buffer-substring beg end)))

(add-hook 'flyspell-incorrect-hook #'my/flyspell-ignore-nonascii)
```

これは <https://takaxp.github.io/init.html#orgdd65fc08> にある設定を持って来ています


## その他 {#その他}

`flyspell-prog-mode` を使うと、文字列やコメントにのみ有効にできるようですがそのあたりはまだ試していません。
