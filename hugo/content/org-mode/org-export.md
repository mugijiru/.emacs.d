+++
title = "org-export"
draft = false
weight = 7
+++

## 概要 {#概要}

ここではファイルへの出力用の設定をまとめている。というか昔書いた設定をとりあえずここに押し込めている


## footnote や制作者などを出力しない {#footnote-や制作者などを出力しない}

HTML で記事を吐き出す時に邪魔だったの非表示にしている記憶。随分昔に設定したのであんまり覚えてない。

```emacs-lisp
;; フッターなくしたり
(setq org-export-html-footnotes-section "")
(setq org-export-html-footnote-format "")
(setq org-export-with-footnotes nil)
(setq org-export-with-creator nil)
(setq org-export-with-author nil)
(setq org-html-validation-link nil)
```

以下は seesaa blog への吐き出し用設定なのだけどもう向こうを更新することはないので消しても良さそう

```emacs-lisp
;; for seesaa blog settings
(setq org-export-author-info nil)
(setq org-export-email-info nil)
(setq org-export-creator-info nil)
(setq org-export-time-stamp-file nil)
(setq org-export-with-timestamps nil)
(setq org-export-with-section-numbers nil)
(setq org-export-with-sub-superscripts nil)
```


## Table of Contents 出力抑制 {#table-of-contents-出力抑制}

これも自分の用途では要らなかったけどファイル単位とかで制御しても良い気がする

```emacs-lisp
(setq org-export-with-toc nil)
```


## サイト名の出力 {#サイト名の出力}

seesaa blog 用に記事を吐き出していた時はページ全体ではなく記事部分だけ出力したかったのでつまり h1 とかはもうテンプレート側に埋め込まれているので出す必要がなかった

というわけで h1 でサイト名を出さないようにしている

```emacs-lisp
(setq org-export-html-preamble nil)
(setq org-html-preamble nil)
```


## bold, italic などの抑制 {#bold-italic-などの抑制}

アスタリスクで囲ったりスラッシュでアンダースコアで囲ったりすると
b タグや i タグ、 u タグにする機能があるが
HTML 4.01 Strict 信者だったこともあって抑制している。

アスタリスクで囲む時、重要と思って囲むので、そういう意味では em とかで出る方が適切だと思う。

```emacs-lisp
;;; *bold* とか /italic/ とか _underline_ とかを<b>とかにしないようにする
(setq org-export-with-emphasize nil)
```


## export のデフォルト出力言語は日本語 {#export-のデフォルト出力言語は日本語}

まあ日本語しか書かないので……

```emacs-lisp
(setq org-export-default-language "ja")
```
