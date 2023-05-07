+++
title = "ruby"
draft = false
+++

## 概要 {#概要}

Ruby のコードを編集する上での設定をここには書いている。別の箇所で [rspec-mode]({{< relref "rspec-mode" >}}) などの設定も書いているのでいつか記述場所を統合した方が良さそうな気もする


## rbenv.el {#rbenv-dot-el}

Ruby のバージョンを切り替えられる [rbenv](https://github.com/rbenv/rbenv) を使ってるので
Emacs 上でもそれが使えるように [rbenv.el](https://github.com/senny/rbenv.el) を導入している。


### インストール {#インストール}

インストールはいつも通り el-get でやっている

```emacs-lisp
(el-get-bundle rbenv)
```


### 有効化 {#有効化}

そして global に有効化している。というか global じゃない有効化ってあるのかなってのと、あるとしても意味があるのかな的な。

```emacs-lisp
(global-rbenv-mode)
```


## enh-ruby-mode {#enh-ruby-mode}

メジャーモードは [enhanced-ruby-mode](https://github.com/zenspider/enhanced-ruby-mode) を利用している。が、最近は ruby-mode の方がやっぱり良いみたいな話もどこかで見た気がするので戻ってみるのも手かもしれないと思っている。


### インストール {#インストール}

いつも通り el-get で入れている。

```emacs-lisp
(el-get-bundle enh-ruby-mode)
```


### カスタム設定 {#カスタム設定}

enh-ruby-mode が読み込まれた後に setq で以下のように設定されている

```emacs-lisp
(with-eval-after-load 'enh-ruby-mode
  (setq enh-ruby-add-encoding-comment-on-save nil)
  (setq enh-ruby-deep-indent-paren nil)
  (setq enh-ruby-deep-indent-construct nil)
  (setq enh-ruby-bounce-deep-indent nil))
```


#### encoding のマジックコメントが入らないようにする {#encoding-のマジックコメントが入らないようにする}

`enh-ruby-add-encoding-comment-on-save` を nil にすることで
encoding 設定のマジックコメントが入らないようにしている。

これは昔は有効にしておいた方が良かったけど最近の Ruby では設定しなくても UTF-8 が前提になるからむしろ無い方が良いというお話だったはず。

そういう状況に変わったのも大分前なので詳細は忘れた。

ただとりあえず [最新の enhanced-ruby-mode](https://github.com/zenspider/enhanced-ruby-mode/blob/e960bf941d9fa9d92eabf7c03a8bbb51ba1ac453/enh-ruby-mode.el#L74) を見るとデフォルトが nil なのでわざわざ設定しなくて良さそう。


#### インデントの調整 {#インデントの調整}

`enh-ruby-deep-indent-paren` が t の場合

```ruby
hoge = {
         foo: 1
       }
```

みたいな深いインデントになるけど

```ruby
hoge = {
  foo: 1
}
```

というようにしたいので nil に設定している。


#### インデントの切替 {#インデントの切替}

インデントを深くしたくないといいつつ、全然それができないのも困りそうなので
`enh-ruby-bounce-deep-indent` を t に設定してタブを押すごとに切り替わるようにしている。

ところでデフォルトで深い方になってるような気がするので今度設定の見直しした方が良さそう。


### hook {#hook}

hook 用の関数で補完などの機能を有効にしている

```emacs-lisp
(defun my/enh-ruby-mode-hook ()
  (company-mode 1)
  (lsp)
  (lsp-ui-mode 1)
  (add-hook 'before-save-hook #'lsp-format-buffer nil 'local)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode 1))
```

-   補完用に company-mode を有効化
-   [solargraph](https://github.com/castwide/solargraph) を使ってるので lsp-mode を有効にしている
    -   lsp-ui-mode も有効にして色々な情報を表示している
-   また lsp-mode の自動フォーマットを保存時に実行するようにしている
-   開きカッコと閉じカッコの組み合わせがズレないように smartparens-strict-mode を有効にしている
-   行番号も表示されている方が便利なので display-line-numbers-mode を有効にしている

それらを設定する関数を enh-ruby-mode-hook に突っ込んでいる

```emacs-lisp
(add-hook 'enh-ruby-mode-hook 'my/enh-ruby-mode-hook)
```


### SKK の調整 {#skk-の調整}

`enh-ruby-mode` を `context-skk-programming-mode` に追加することで
Ruby を使ってる時にコメント部分はクォートの外以外では自動的に日本語入力がオフになるようにしている

```emacs-lisp
(add-to-list 'context-skk-programming-mode 'enh-ruby-mode)
```


### キーバインド {#キーバインド}

キーバインドは覚えられないので
[major-mode-hydra]({{< relref "neotree#major-mode-hydra" >}}) でキーを定義している

```emacs-lisp
(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define enh-ruby-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-alltheicon "ruby-alt") " Ruby commands"))
    ("Enh Ruby"
     (("{" enh-ruby-toggle-block "Toggle block")
      ("e" enh-ruby-insert-end "Insert end"))

     "LSP"
     (("i" lsp-ui-imenu "Imenu")
      ("f" lsp-ui-flycheck-list "Flycheck list"))

     "RSpec"
     (("s" rspec-verify "Run associated spec")
      ("m" rspec-verify-method "Run method spec")
      ("r" rspec-rerun "Rerun")
      ("l" rspec-run-last-failed "Run last failed"))

     "REPL"
     (("I" inf-ruby "inf-ruby"))

     "Other"
     (("j" dumb-jump-go "Dumb Jump")))))
```

| Key | 効果                                                |
|-----|---------------------------------------------------|
| {   | do 〜 end と { 〜 } を切り替える                    |
| e   | end を挿入する。使ったことない気がする              |
| i   | lsp-ui-imenu の表示                                 |
| f   | Flycheck の通知されるエラーのリスト表示             |
| s   | 関連するテストまたは特定のテストの実行              |
| m   | カーソル位置のコードのテストを探して実行する        |
| r   | 最後に実行したテストを再実行                        |
| l   | 最後に失敗したテストの再実行                        |
| I   | REPL バッファで Ruby を実行する                     |
| j   | dumb-jump で関数定義にジャンプ。dumb-jump 用の hydra があるから要らなさそう |
