+++
title = "ガベージコレクション"
draft = false
+++

## 概要 {#概要}

ガベージコレクションには gcmh というのを利用してみている。

<https://github.com/emacsmirror/gcmh>

普段は GC を控えめにしながら操作してない間に GC が走るような作りになっている。便利そう。


## インストール {#インストール}

```emacs-lisp
(el-get-bundle gcmh)
```

これだけで有効化もされる。


## その他 {#その他}

以前の設定も折り畳んで残しておく

<details>
<summary>
使わなくなったコード
</summary>
<p class="details">

gcmh を入れる前に設定していたコード。
gcmh を入れたらこれよりもいい感じに対応してくれそうなので入れ替えた。

```emacs-lisp
;; https://gist.github.com/garaemon/8851900ef27d8cb28200ac8d92ebacdf
;; Increase threshold to fire garbage collection
(setq gc-cons-threshold 1073741824)
(setq garbage-collection-messages t)

;; Run GC every 60 seconds if emacs is idle.
(run-with-idle-timer 60.0 t #'garbage-collect)
```
</p>
</details>
