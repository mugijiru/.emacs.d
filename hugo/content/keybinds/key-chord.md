+++
title = "key-chord"
draft = false
+++

## 概要 {#概要}

[key-chord](https://github.com/emacsorphanage/key-chord) はキーを同時に押した時にコマンドを発動させるということができるようにしてくれるパッケージ。


## インストール {#インストール}

el-get 本体にレシピが用意あれているのでそれを使っている

そして `el-get-bundle` でインストールしている。

```emacs-lisp
(el-get-bundle key-chord)
```


## 設定 {#設定}

同時押し時の許容時間、その前後で別のキーが押されていたら発動しない判断をする、みたいな設定を入れている。

```emacs-lisp
(setopt key-chord-two-keys-delay 0.25)
```

キーの同時押し判定は 0.25 秒という設定にしている。


## 有効化 {#有効化}

設定を入れた後は有効にするだけである。

```emacs-lisp
(key-chord-mode 1)
```

実際のキーバインド設定は各モードだったりグローバルキーバインドを設定しているファイルだったりで書く感じ。

といいつつ現状では Hydra 起動のやつしか使ってないので、グローバルキーバインド設定でしか書いてない。


## sticky-shift {#sticky-shift}


### セミコロン2つでシフトを押した状態にする {#セミコロン2つでシフトを押した状態にする}

セミコロンを2回叩くことで shift が押されてるという状態を実現する。

これにより magit で P などを入力したい時にも `;;p` で入力できるし通常の英字入力時にも大文字にできるので左手小指が痛い時には Shift を使わずに操作ができるようになる。

```emacs-lisp
(key-chord-define-global ";;"
                         'event-apply-shift-modifier)

(key-chord-define key-translation-map
                  ";;"
                  'event-apply-shift-modifier)
```

`global-key-map` と `key-translation-map` の両方に定義しないと動かないがその原因はよく分かってない。一旦動くから良しとしている。

ここで使っている `event-apply-shift-modifier` はデフォルトでは `C-x @ S` にバインドされているやつ。お仲間に `event-apply-control-modifier` などの各 modifier キーがいるので
sticky 的なことをやる上で便利な子達。
[sticky-control]({{< relref "sticky-control" >}}) の中でも `event-apply-control-modifier` が使われているぞい。


### やりたかったけど実現できてないこと {#やりたかったけど実現できてないこと}


#### セミコロン\*2+数字キー、セミコロン\*2+記号キーの対応 {#セミコロン-2-plus-数字キー-セミコロン-2-plus-記号キーの対応}

[sticky.el](https://www.emacswiki.org/emacs/sticky.el) では実現されてそうなことなので、同じことをできるようにしたい


## その他 {#その他}

[sticky-control]({{< relref "sticky-control" >}}) も control 限定で似たようなことをしているので
key-chord に全部置き換えできるかもしれない。
