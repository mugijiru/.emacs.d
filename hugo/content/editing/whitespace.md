+++
title = "whitespace"
draft = false
+++

## 概要 {#概要}

whitespace-mode は Emacs に標準添付されている、空白文字を可視化したりするためのモード。

全角空白を可視化したり、行末の空白を可視化したりしておくと便利なので入れている。


## 設定 {#設定}

```emacs-lisp
(require 'whitespace)
```


## 可視化対象 {#可視化対象}

可視化対象の空白について設定している。

```emacs-lisp
(setq whitespace-style '(face
                         trailing
                         tabs
                         spaces
                         empty
                         space-mark
                         tab-mark))
```

| 値         | 意味                                        |
|-----------|-------------------------------------------|
| face       | face による可視化を有効にする。これがないと \*-mark 以外が有効にならない |
| trailing   | 行末の空白を可視化する                      |
| tabs       | タブ文字の可視化                            |
| spaces     | 空白の可視化。ただし後の設定で全角のみを可視化するようにている |
| empty      | バッファの前後に空行があれば可視化          |
| space-mark | 空白文字を別の文字に置き換える設定。置き換え文字は後述 |
| tab-mark   | タブ文字を別の文字に置き換える設定。置き換え文字は後述 |

他にも lines, lines-tail, indentation, big-indent, newline-mark などがある

lines-tail あたりを使うと1行80文字制限でコーディングする時などに便利かもしれないなって思ってる。設定したことがないからわからんが……。


## 置き換え表示用の文字の設定 {#置き換え表示用の文字の設定}

```emacs-lisp
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
```

| 置き換え元 | 置き換え先                                 |
|-------|---------------------------------------|
| 空白文字 | 　                                         |
| タブ文字 | » + TAB を表示する。もしそれが表示できない時は \\ + TAB で代替する |

どこかからコピペしてきたやつなので英語のコメントもあるが「なんかうまく動かなかったらコメントアウトしてくれよな」って感じ。ま、うまく動いてそうなのでヨシッ!


## スペースは全角のみを可視化 {#スペースは全角のみを可視化}

半角スペースまでいちいち可視化されてたら邪魔だし気付きたいのは全角スペースが紛れてるかどうかなので、空白文字ではそれだけを可視化するようにしている。

```emacs-lisp
(setq whitespace-space-regexp "\\(\u3000+\\)")
```


## 行末の空白も表示 {#行末の空白も表示}

通常の半角空白と No Break Space(`&nbsp;` で表示されるやつ) を行末での可視化対象としている。

```emacs-lisp
(setq whitespace-trailing-regexp  "\\([ \u00A0]+\\)$")
```

タブも入れてもまあいいんだろうけど、別途可視化しているからわざわざ入れなくても良いということでこうしている気がする。


## 保存前に自動でクリーンアップ {#保存前に自動でクリーンアップ}

保存時なんかに自動的に余計な空白を消すような設定。保存する時に、バッファ前後の無駄な空白や末尾の空白なんかを取り除いてくれる。

```emacs-lisp
(setq whitespace-action '(auto-cleanup))
```

実はスペースとタブが混ざってる時などもいい感じに対応してくれそうな雰囲気があるけどそもそもスペースとタブが混ざるような設定にしてないのでそれは観測できてない。


## Emacs 全体で有効化 {#emacs-全体で有効化}

とまあ、上で設定してきたように、色々可視化されたり余計な空白を処理してくれたりで便利なやつなので、
Emacs 全体で有効にしている。

```emacs-lisp
(global-whitespace-mode 1)
```
