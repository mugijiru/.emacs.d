+++
title = "Vue.js"
draft = false
+++

## 概要 {#概要}

ここでは Vue.js アプリケーションを書く上での設定を書いている。


## auto-insert の設定 {#auto-insert-の設定}

Vue.js のコンポーネントファイルを新規作成する時にテンプレートが自動挿入できるようにしている


### テンプレート {#テンプレート}

Vue.js の単一ファイルコンポーネントなので template, script, style を出力している。

template には [pug](https://pugjs.org/api/getting-started.html) を、CSS には scss を使っている。

```html
<template lang='pug'>
</template>

<script>
export default {

};
</script>

<style lang='scss' scoped>
</style>
```


### テンプレートを適用可能にする {#テンプレートを適用可能にする}

`.vue` という拡張子のファイルを新規作成する時には上で定義したテンプレートが自動的に挿入されるようにする。

```emacs-lisp
(define-auto-insert "\\.vue$" "template.vue")
```


## パッケージのインストール {#パッケージのインストール}

ここでは Vue.js 開発に使っている関連パッケージを入れている。


### vue-mode {#vue-mode}

[vue-mode](https://github.com/AdamNiederer/vue-mode) は [mmm-mode](https://github.com/purcell/mmm-mode) をベースにして作られた Vue.js の単一ファイルコンポーネント用のモード。
mmm-mode ベースなので
template, script, css 部分でそれぞれ別のメジャーモードが動くようになっている。


#### インストール {#インストール}

el-get レシピは自前で用意している

```emacs-lisp
(:name vue-mode
       :description "Major mode for vue component based on mmm-mode"
       :type github
       :pkgname "AdamNiederer/vue-mode"
       :depends (ssass-mode mmm-mode edit-indirect vue-html-mode))
```

また、依存しているパッケージもいくつかレシピを自前で用意している

```emacs-lisp
(:name vue-html-mode
       :description "Major mode for editing Vue.js templates"
       :type github
       :pkgname "AdamNiederer/vue-html-mode")
```

```emacs-lisp
(:name edit-indirect
       :description "Edit regions in separate buffers"
       :type github
       :pkgname "Fanael/edit-indirect")
```

```emacs-lisp
(:name ssass-mode
       :description "Edit Sass without a Turing Machine"
       :type github
       :pkgname "AdamNiederer/ssass-mode")
```

```emacs-lisp
(:name mmm-mode
       :description "Allow Multiple Major Modes in a buffer"
       :type github
       :pkgname "purcell/mmm-mode"
       :depends (cl-lib))
```

いつも透り el-get で入れている

```emacs-lisp
(el-get-bundle vue-mode)
```


#### 備考 {#備考}

あまり更新は活発でなく微妙な挙動もあるので
mmm-mode に乗り換えたり web-mode を使うようにしている人も多い様子。

自分もそういった乗り換えを検討した方がいいかもと思いつつ最近あまり Vue.js 触ってないから、まあいいかという気持ちもある。

なお vue-mode では JS 部分は js2-mode は使えないはず。
mmm-mode の方が何かの制限で使えないという話だったはずなので。
<https://github.com/mooz/js2-mode/issues/124>


### pug-mode {#pug-mode}

[pug-mode](https://github.com/hlissner/emacs-pug-mode) は [pug](https://pugjs.org/api/getting-started.html) というテンプレートエンジンを使って記述するためのモード。
Vue.js でテンプレートエンジンに pug を利用することが多いので入れている。麦汁さんは HTML をそのまま書くようなことは好きじゃないのです。


#### インストール {#インストール}

いつも透り el-get で入れている

```emacs-lisp
(el-get-bundle hlissner/emacs-pug-mode)
```


## hooks {#hooks}

css-mode と vue-mode だけは hook を定義している。
pug-mode や js-mode についても何か手を入れた方がいいのかもしれない。


### css-mode {#css-mode}

Vue.js では style に scss を指定いちえる場合には css-mode が利用されるようになっているので
css-mode の hook としている。
<https://github.com/AdamNiederer/vue-mode/blob/031edd1f97db6e7d8d6c295c0e6d58dd128b9e71/vue-mode.el#L63>

```emacs-lisp
(defun my/css-mode-hook ()
  (setq-local flycheck-checker 'css-stylelint)
  (rainbow-mode 1))

(add-hook 'css-mode-hook 'my/css-mode-hook)
```

見ての透り rainbow-mode と flycheck-checker の設定ぐらいしかしてない。
[scss-mode]({{< relref "scss#scss-mode" >}}) の方ではもう少し手を入れているので同じようなのをここに反映してもいいかもしれない。

もしくは設定を統合するという手もあるかも。


### vue-mode {#vue-mode}

```emacs-lisp
(defun my/vue-mode-hook ()
  (display-line-numbers-mode t)
  (lsp)
  (flycheck-mode 1))

(add-hook 'vue-mode-hook 'my/vue-mode-hook)
```

-   行番号表示
-   lsp を有効化
-   flyckeck-mode を有効化

しているだけである。
lsp-ui とか色々設定の余地はありそうな気がする。


## キーバインド {#キーバインド}

これもろくに設定してないし、ろくに使ってないもいないが、一応設定自体はある。

```emacs-lisp
(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define css-mode (:quit-key "q" :title (concat (all-the-icons-alltheicon "css3") " CSS"))
    ("Edit"
     (("v" my/replace-var "replace-var")))))
```

| Key | 効果                                      |
|-----|-----------------------------------------|
| v   | リージョンの値で CSS 変数を検索して置き換えるやつ。自作コマンドを利用している |
