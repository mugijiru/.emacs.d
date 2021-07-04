+++
title = "flycheck"
draft = false
+++

## 概要 {#概要}

[flycheck](https://www.flycheck.org/en/latest/) はリアルタイムで文法チェックなんかをするのに便利なモード。
flymake よりモダンなやつだったんだけど最近は flymake に戻る人もいるっぽいのでどっちが良いかよくわかってない


### インストール {#インストール}

flycheck と同時にカーソルのそばに pos-tip で通知内容を表示してくれる [flycheck-pos-tip](https://github.com/flycheck/flycheck-pos-tip) をインストールしている

```emacs-lisp
(el-get-bundle flycheck)
(el-get-bundle flycheck-pos-tip)
```


### 設定 {#設定}

flycheck を読んだ後で flycheck-pos-tip-mode が有効になるようにしている。これは公式に書かれているやりかたに則っている
<https://github.com/flycheck/flycheck-pos-tip#installation>

```emacs-lisp
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))
```


### その他 {#その他}


#### flycheck-posframe {#flycheck-posframe}

flycheck-pos-tip は flycheck 公式のプラグインなので採用しているけど同じことを posframe でやってくれる [flycheck-posframe](https://github.com/alexmurray/flycheck-posframe) に置き換えた方が見た目麗しくなりそうな気がしている。


#### 言語毎の設定 {#言語毎の設定}

各言語向けの設定もあるけどそれは各言語の設定ファイル内に書いているのでここでは書いてない

[プログラミング関係の設定 > ruby]({{< relref "ruby" >}}) とか [プログラミング関係の設定 > scss]({{< relref "scss" >}}) とかに書いているはず
