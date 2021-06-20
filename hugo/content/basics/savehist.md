+++
title = "savehist"
draft = false
+++

## 概要 {#概要}

Emacs 標準でついている、ミニバッファの履歴などを保存してくれる機能。


## 有効化 {#有効化}

標準でついているので以下のようにするだけで有効化可能。

```emacs-lisp
(savehist-mode 1)
```


## 設定 {#設定}

標準で保存されるもの以外だと kill-ring だけを保存対象にしている。これで Emacs を終了させても kill-ring は残るようになるはず。だけど最近使えてない気がするな……。検証が必要そう。

```emacs-lisp
(setq savehist-additional-variables '(kill-ring))
```

他にも有効にしたら便利そうなのがあれば追加したい。が、ぱっとは思い付かない。
