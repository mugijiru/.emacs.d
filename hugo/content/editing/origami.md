+++
title = "origami"
draft = false
+++

## 概要 {#概要}

[origami](https://github.com/elp-revive/origami.el) はコードの折り畳み機能を提供するやつ。メジャーな言語は大体サポートしている感じ。大きいファイルを見る時に便利。


## インストール {#インストール}

el-get 公式にはレシピがないので自前でレシピを用意している。

```emacs-lisp
(:name origami
       :website "https://github.com/elp-revive/origami.el"
       :description "A text folding minor mode for Emacs."
       :type github
       :pkgname "elp-revive/origami.el"
       :depends (s dash))
```

そしてそれを使ってインストール

```emacs-lisp
(el-get-bundle origami)
```


## キーバインド {#キーバインド}

origami-mode-map では以下のように動くように設定している。

| Key               | 効果                                     |
|-------------------|----------------------------------------|
| &lt;backtab&gt;   | 再帰的に折り畳んだり開いたりするやつ。org-mode の fold と似た感じ |
| M-&lt;backtab&gt; | そのノードだけ表示する                   |

```emacs-lisp
(with-eval-after-load 'origami
  (define-key origami-mode-map (kbd "<backtab>") 'origami-recursively-toggle-node)
  (define-key origami-mode-map (kbd "M-<backtab>") 'origami-show-only-node))
```

ただこれだけだと多分足りないので Hydra で色々定義している。

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define origami-hydra
    (:separator "-" :quit-key "q" :title "Origami")
    ("Node"
     (("o" origami-open-node "Open")
      ("c" origami-close-node "Close")
      ("s" origami-show-node "Show")
      ("t" origami-toggle-node "Toggle")
      ("S" origami-forward-toggle-node "Foward toggle")
      ("r" origami-recursively-toggle-node "Recursive toggle"))

     "All"
     (("O" origami-open-all-nodes "Open")
      ("C" origami-close-all-nodes "Close")
      ("T" origami-toggle-all-nodes "Toggle"))

     "Move"
     (("n" origami-next-fold "Next")
      ("p" origami-previous-fold "Previous"))

     "Undo/Redo"
     (("/" origami-undo "Undo")
      ("?" origami-redo "Redo")
      ("X" origami-reset "Reset")))))
```

この設定は [jk で起動する Hydra]({{< relref "hydra#main" >}}) から呼び出せるようにしている
