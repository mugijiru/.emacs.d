+++
title = "emacs-w3m"
draft = false
+++

## 概要 {#概要}

w3m という和製のテキストブラウザを Emacs 上で使うためのパッケージ。つまり w3m 自体もインストールしておく必要がある。


## インストール {#インストール}

emacs-w3m は el-get で入れられるので以下のようにして入れている

```emacs-lisp
(el-get-bundle emacs-w3m)
```


## フィルタ {#フィルタ}

emacs-w3m には w3m-filter という機能がある。これは表示するページの HTML を加工してくれるフィルタでつまり余計な要素を削除したり、別の HTML 要素に置き換えたりできる機能。

一般的なウェブページはテキストブラウザで見ると画面上部の方にメニュー類が大量に表示されてコンテンツ本体に辿り着くまでにたくさんスクロールするハメになるのでそういう部分をさくっと消したりするのに使うと便利。

といいつつ、私が今のところ自前で設定しているのは [るりまサーチ](https://rurema.clear-code.com/) の検索結果ページぐらいですが。

まず、るりまサーチの検索結果ページのフィルタを関数として定義しているその際 `w3m-filter-delete-regions` や `w3m-filter-replace-regex` といった便利なマクロが用意されているのでそれを活用している

以下はいくつかのメニュー項目を非表示にするフィルタである

```emacs-lisp
(defun w3m-filter-rurema (url)
  (goto-char (point-min))
  (let ((deletions '(("<div class=\"description\">" . "</div>")
                     ("<div class=\"version-select\">" . "</div>")
                     ("<div class=\"topic-path\">" . "</div>")
                     ("<div class=\"drilldown list-box\">" . "</div>"))))
    (dolist (deletion deletions)
      (let ((begin-regex (car deletion))
            (end-regex (cdr deletion)))
        (w3m-filter-delete-regions url begin-regex end-regex)))))
```

そしてそれを以下のように `w3m-filter-configuration` に追加している

```emacs-lisp
(add-to-list 'w3m-filter-configuration
             '(t
               ("Strip Rurema menus" "Rurema のメニュー等を取り除きます")
               "\\`https://rurema\\.clear-code\\.com/"
               w3m-filter-rurema))
```
