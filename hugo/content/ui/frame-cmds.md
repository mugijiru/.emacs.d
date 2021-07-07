+++
title = "frame-cmds"
draft = false
+++

## 概要 {#概要}

[frame-cmds](https://www.emacswiki.org/emacs/frame-cmds.el) は Emacs のフレーム操作に関するコマンド集。上下左右に移動したり広げたりといったことができる。いや、他にもできそうなんだけど、私がそれを把握してない。


## インストール {#インストール}

el-get で以下のように書くと emacswiki からインストールされる。

```emacs-lisp
(el-get-bundle frame-cmds)
```


## キーバインド {#キーバインド}

無論キーバインドは覚えられないので以下のように Hydra で定義している

```emacs-lisp
(pretty-hydra-define window-control-hydra (:separator "-" :title "Window Control" :exit nil :quit-key "q")
  ("Move"
   (("h" move-frame-left  "Left")
    ("j" move-frame-down  "Down")
    ("k" move-frame-up    "Up")
    ("l" move-frame-right "Right"))

   "Resize"
   (("H" shrink-frame-horizontally "H-")
    ("J" enlarge-frame "V+")
    ("K" shrink-frame "V-")
    ("L" enlarge-frame-horizontally "H+"))))
```

| Key | 効果     |
|-----|--------|
| h   | 左に移動 |
| j   | 下に移動 |
| k   | 上に移動 |
| l   | 右いん移動 |
| H   | 左右方向に縮める |
| J   | 上下方向に広げる |
| K   | 上下方向に縮める |
| L   | 左右方向に広げる |
