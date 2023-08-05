+++
title = "posframe"
draft = false
+++

## 概要 {#概要}

[posframe](https://github.com/tumashu/posframe) は child frame を表示させるためのパッケージ。
Emacs のど真ん中に表示したり、今あるカーソル位置のすぐそばに出したりできる。

ivy なんかを使う時に [ivy-posframe](https://github.com/tumashu/ivy-posframe) をど真ん中に出すと、いつもそこに表示されるし真ん中なの視線移動が少なくて済むし
[ddskk-posframe](https://github.com/conao3/ddskk-posframe.el) なんかで変換候補をカーソル位置のそばに出て来るので一般的な日本語変換ソフトと同様にこれまた視線移動が少なくて便利。

という感じで色々なものの拡張として使わているやつ。


## インストール {#インストール}

いつも通り el-get で入れているだけ。

```emacs-lisp
(el-get-bundle posframe)
```

こいつ自体には特に設定を入れてない。というか設定項目自体2個しか存在していない。

ま、こいつ単体で使うものでもないしね。
