+++
title = "zoom-window"
draft = false
+++

## 概要 {#概要}

[zoom-window](https://github.com/emacsorphanage/zoom-window) は tmux の prefix z のような動きをするやつ。表示している window をフレーム全体に広げたり戻したりすることができる。


## インストール {#インストール}

いつも通り el-get から入れている

```emacs-lisp
(el-get-bundle zoom-window)
```


## その他 {#その他}

キーバインドは 80-global-keybinds に書いたけど
`C-x 1` に割り当てている。

ただそれだと tmux と使い勝手が違うなって感じているのでそのうち hydra の中の z にでもアサインしようかと思う。

あと、その window を最大化して戻すことよりも単に他の window が邪魔なことの方が多い気もしている。。。
