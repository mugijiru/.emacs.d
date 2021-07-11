+++
title = "key-chord"
draft = false
+++

## 概要 {#概要}

[key-chord](https://github.com/emacsorphanage/key-chord) はキーを同時に押した時にコマンドを発動させるということができるようにしてくれるパッケージ。

なのですが[本家の方だと誤爆が多い](https://qiita.com/zk%5Fphi/items/e70bc4c69b5a4755edd6)ということなのでそれを改善した [zk-phi/key-chord](https://github.com/zk-phi/key-chord/) の方を利用している。

まあほとんど使えてないので改良版の恩恵をまだ受けてないけど……。


## インストール {#インストール}

いつも通り el-get でインストールしている。本家の方じゃないので GitHub のリポジトリから突っ込んでいる。

```emacs-lisp
(el-get-bundle zk-phi/key-chord)
```


## 設定 {#設定}

同時押し時の許容時間、その前後で別のキーが押されていたら発動しない判断をする、みたいな設定を入れている。

```emacs-lisp
(setq key-chord-two-keys-delay           0.25
      key-chord-safety-interval-backward 0.1
      key-chord-safety-interval-forward  0.15)
```

キーの同時押し判定は 0.15 秒で、それらのキーが押される直前の 0.1 秒以内、または直後の 0.15 秒に押されていたら発動しない、という設定にしている。

改良版の作者の記事だと、直後判定は 0.25 秒で設定されていたが自分は Hydra の起動に使っている上に Hydra で叩けるやつでよく使うやつは覚えているので表示を待たずに次のキーを押すので 0.25 秒も待っていられないという事情があった。


## 有効化 {#有効化}

設定を入れた後は有効にするだけである。

```emacs-lisp
(key-chord-mode 1)
```

実際のキーバインド設定は各モードだったりグローバルキーバインドを設定しているファイルだったりで書く感じ。

といいつつ現状では Hydra 起動のやつしか使ってないので、グローバルキーバインド設定でしか書いてない。


## sticky-shift {#sticky-shift}


### セミコロン+アルファベット入力で大文字とする {#セミコロン-plus-アルファベット入力で大文字とする}

セミコロンとアルファベットをほぼ同時に叩くことにより対応する大文字を出力できるようにしている。

これで PascalCase を入力しないといけない時でもシフトキーを叩かずに済む。少し慣れは必要だけども。

```emacs-lisp
(mapc (lambda (key)
        (key-chord-define-global (concat ";" (char-to-string key)) (char-to-string (- key 32))))
      (number-sequence ?a ?z))
```


### セミコロン2つでシフトを押した状態にする {#セミコロン2つでシフトを押した状態にする}

上に書いたやつだけだと設定が足りなくて何故かというと、
magit を使う時なんかは結構 P とかで push したりするけども上記の設定だと `;p` を入力しても、あくまで文字の出力が変わるだけになってしまうため
magit のコマンドとして成立しない。

そこでセミコロンを2回叩くことで shift が押されてるという状態を実現する。

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


#### セミコロン+アルファベット入力で大文字を入力したことにする {#セミコロン-plus-アルファベット入力で大文字を入力したことにする}

今だとセミコロン+アルファベット入力ではその文字を出力することしかできてないので
magit を操作する時はセミコロンを2回叩く必要があってだるいなって。


#### セミコロン+数字キー、セミコロン+記号キーの対応 {#セミコロン-plus-数字キー-セミコロン-plus-記号キーの対応}

[sticky.el](https://www.emacswiki.org/emacs/sticky.el) では実現されてそうなことなので、同じことをできるようにしたいのと「セミコロン2回 + 数字または記号キー」みたいな組み合わせも対応していきたい


## その他 {#その他}

[sticky-control]({{< relref "sticky-control" >}}) も control 限定で似たようなことをしているので
key-chord に全部置き換えできるかもしれない。
