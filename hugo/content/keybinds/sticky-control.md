+++
title = "sticky-control"
draft = false
+++

## 概要 {#概要}

指定したキーを2回叩いたら
Control が押されてるような状態にしてくれるプラグイン。

その2回の間隔はデフォルトだと 0.5 秒以内となっている。そのため、そのキーを押して 0.5 秒が経過したら、普通にそのキーが押されたことになる

さらに `sticky-control-shortcuts` に指定されてる一部のキーについては
sticky 用のキーを押した直後に shortcuts のキーを押すと
Control を押している状態でそのキーを押したことになる。

例えば私は `,` を sticky 用のキーにしていて
shortcuts に `c` を入れているので
`,c` と素早くタイプをすればそれだけで `C-c` が押された状態になる。


## インストール {#インストール}

まずは el-get-bundle でインストール。

```emacs-lisp
(el-get-bundle sticky-control)
```

ちなみにレシピは公式ではなかったのでとりあえず自分の環境で使えるように自作レシピを置いている。

```emacs-lisp
(:name sticky-control
       :description "save your left little finger"
       :type http
       :url "https://raw.githubusercontent.com/martialboniou/emacs-revival/master/sticky-control.el"
       :features "sticky-control")
```

元々は <http://www.cs.toronto.edu/~ryanjohn/sticky-control.el> にあったのだけど最近そこからは取得できなくなったので
<https://github.com/martialboniou/emacs-revival/blob/master/sticky-control.el>
から取得して利用している


## 設定 {#設定}

まずは「2回叩いたら Control を押している状態になる」キーを指定する。

```emacs-lisp
(sticky-control-set-key 'sticky-control-key ?,)
```

私は `,` を sticky-control のキーにしているのでこの指定。

そして次に `sticky-control-shortuts` の指定。ここに指定しておくと、例えば `,c` と素早くタイプすることで `C-c` が入力された状態とすることができる。

```emacs-lisp
(setq sticky-control-shortcuts
      '((?c . "\C-c")
        (?g . "\C-g")
        (?k . "\C-k")
        (?a . "\C-a")
        (?e . "\C-e")
        (?n . "\C-n")
        (?o . "\C-o")
        (?p . "\C-p")
        (?j . "\C-j")
        (?f . "\C-f")
        (?b . "\C-b")
        (?x . "\C-x")
        (?r . "\C-r")
        (?s . "\C-s")))
```

結構な数を指定しているけど、普段そんなに使えているわけでもない。まあ、大体 Control を押しながら使いそうなところは押さえてあるので何も考えずとも使えるようにしてある。


## 有効化 {#有効化}

最後に有効化

```emacs-lisp
(sticky-control-mode)
```
