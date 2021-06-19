+++
title = "run-tests"
draft = false
weight = 2
+++

読み込んだテストをまるっとテストするためのコードをとりあえず置いている。

```emacs-lisp
(if noninteractive
    (let ((ert-quiet t))
      (ert-run-tests-batch-and-exit)))
```

後述の [テストライブラリの読み込み]({{< relref "my-org-commands-test#テストライブラリの読み込み" >}}) などはここで担うべきかとも考えるが今はテストファイルが1つしかないので気にしないことにする。
