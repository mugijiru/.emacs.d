+++
title = "show-paren-mode"
draft = false
+++

## 概要 {#概要}

[show-paren-mode](https://www.emacswiki.org/emacs/ShowParenMode) は Emacs に標準で入っているやつで開き括弧と閉じ括弧の対応を示してくれたり括弧の中身を強調表示したりする機能を提供してくれるやつ。


## 有効化 {#有効化}

デフォで入ってるので以下のようにするだけで有効化される。

```emacs-lisp
(show-paren-mode 1)
```

デフォ設定だと対応する括弧を強調表示するだけだけどまあそれで悪くないと思ってるので今のところデフォルト設定のままである。


## その他 {#その他}

<http://syohex.hatenablog.com/entry/20110331/1301584188>

の記事へのリンクを設定ファイルの中に残していたけど設定は特に弄ってないのでまたその記事読んだりで設定弄ってみてもいいかもしれない。

また smartparens.el にも似た機能はあるようだけど
Emacs 標準機能の方が軽そうなのでとりあえずこのままにするつもり。
