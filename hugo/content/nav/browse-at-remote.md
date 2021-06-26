+++
title = "browse-at-remote"
draft = false
+++

## 概要 {#概要}

[browse-at-remote](https://github.com/rmuslimov/browse-at-remote) は Emacs で見ているファイルについて
GitHub や GitLab などのサービス上での該当ブランチ、該当ファイル、該当行を開いてくれる便利なやつ。

業務だとレビュー中に「ここにこういう関数あるよ」みたいに示すことがあるけどその時に Emacs 内で関数を探して browse-at-remote で GitHub 上の位置を開くことでそこへのリンクを拾いやすく便利。


## インストール {#インストール}

いつも透り el-get で入れている。

```emacs-lisp
(el-get-bundle browse-at-remote)
```


## 使い方 {#使い方}

ブラウザで見たい行の上で `M-x browse-at-remote` を実行する。

または Region を選択している状態で実行すると、その範囲を選択している状態で開いてくれる。便利。


## その他 {#その他}

Hydra でいつでも使えるようにキーバインドを割り当てている。
