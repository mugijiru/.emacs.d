+++
title = "3. 予定のカレンダー表示"
draft = false
+++

## 概要 {#概要}

普段の予定をカレンダー表示で見れると嬉しいな〜と思って
[calfw](https://github.com/kiwanami/emacs-calfw) で予定が見れるようにしている。

が、今ここに書いているのはまだ設定の一部である。
agenda 部分と関わっていてまだうまく整理しきれてない。


## 日本の休日 {#日本の休日}

calfw に日本の休日を表示できるように
[japanese-holidays](https://github.com/emacs-jp/japanese-holidays) を入れている。

```emacs-lisp
(el-get-bundle japanese-holidays)
(require 'japanese-holidays)
(setq calendar-holidays (append japanese-holidays))
```

もっとちゃんと設定したら Emacs のデフォルトのカレンダーでも休日表示がわかりやすくなって良いので今度設定し直す。

その時には多分 org-mode カテゴリではないところに移動するはず。


## calfw {#calfw}

calfw を el-get で入れた上で、
org-mode と連携するように calfw-org も require している。

```emacs-lisp
(el-get-bundle calfw)
(require 'calfw)
(require 'calfw-org)
```

ここではまだこれ以上のことはしてない
