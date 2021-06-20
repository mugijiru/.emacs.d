+++
title = "load-path"
draft = false
+++

## 概要 {#概要}

`load-path` は Emacs の設定でも重要な項目でこのリストに追加されている path は `load` または `require` する際に走査される path となっている。

即ち load-path を通しておけば、そこに置いている emacs lisp のファイルは簡単に読み出せるようになる。

なお package-install や el-get を使っておけば基本的に自分で load-path を通す必要はない。


## 秘匿情報を入れてるフォルダを読み込み可能にする {#秘匿情報を入れてるフォルダを読み込み可能にする}

パスワードなどの秘匿情報を持っている部分は `~/.emacs.d/secret` というフォルダで管理している。そのためここに入ってる emacs lisp のファイルも読み込めるように load-path に追加している。

```emacs-lisp
(add-to-list 'load-path (expand-file-name "~/.emacs.d/secret"))
```


## my/load-config {#my-load-config}

`~/.emacs.d/secret` は個人マシンか会社マシンかによって置いてるデータが異なったりするためもしもファイルがなくてもエラーにならないような方法で load する方法が必要だった。

というわけでファイルがなかったら読み込まずにメッセージを出力して終了するような関数を用意している。

```emacs-lisp
(defun my/load-config (file)
  (condition-case nil
      (load file)
    (file-missing (message "Load error: %s" file))))
```

ただ、これって結局

```emacs-lisp
(load file nil t)
```

で十分な気もするので、置き換えを検討した方が良さそう。
