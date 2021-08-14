+++
title = "view-mode"
draft = false
+++

## 概要 {#概要}

[view-mode](https://www.emacswiki.org/emacs/ViewMode) は Emacs に標準で組込まれているモードで、バッファを閲覧専用にする機能を提供してくれるやつ。コードを眺めたい時などに使っている。


## キーバインド {#キーバインド}

view-mode の時は文字入力をする必要がないので通常のモードの時とは違うキーバインドが使えるようにしている。

```emacs-lisp
(defun my/setup-view-mode-keymap ()
    (let ((keymap view-mode-map))
      (define-key keymap (kbd "h") 'backward-char)
      (define-key keymap (kbd "j") 'next-line)
      (define-key keymap (kbd "k") 'previous-line)
      (define-key keymap (kbd "l") 'forward-char)

      (define-key keymap (kbd "e") 'forward-word)

      (define-key keymap (kbd "b")   'scroll-down)
      (define-key keymap (kbd "SPC") 'scroll-up)

      (define-key keymap (kbd "g") 'beginning-of-buffer)
      (define-key keymap (kbd "G") 'end-of-buffer)
      (define-key keymap (kbd "<") 'beginning-of-buffer)
      (define-key keymap (kbd ">") 'end-of-buffer)))
```

| Key  | 効果       |
|------|----------|
| h    | 1文字戻る  |
| j    | 1行下がる  |
| k    | 1行上がる  |
| l    | 1文字進む  |
| e    | 単語の直後に移動 |
| b    | 1スクロール戻る |
| SPC  | 1スクロール進む |
| g, < | バッファの先頭に移動 |
| G, > | バッファの末尾に移動 |

適当だけど Vim の通常モードの時みたいな操作ができるようにしている。

これで不要に左手小指を痛める可能性が下がるであろう。


## hook {#hook}

上でキーバインドを設定できる関数を用意してあるので
view-mode が有効になる時にそれを hook して設定されるようにしている。

が、 hook する必要あるのか疑問ではあるな。ま、動いているからとりあえずいいけど。

```emacs-lisp
(defun my/view-mode-hook ()
  (my/setup-view-mode-keymap))

(add-hook 'view-mode-hook 'my/view-mode-hook)
```


## Toggle するコマンド {#toggle-するコマンド}

view-mode にしたり戻したりするコマンドを用意している。

view-mode を有効にする時には hl-line-mode も有効にしているのでその時眺めている行がハイライトされるようになっている。普段はそれがあるかどうかでどっちもモードかざっくり判断している。

他にも mode-line の色を変更するなどの技があるようだがひとまず今の設定でそう困ってないのでいいかな。

```emacs-lisp
(defun my/toggle-view-mode ()
  "view-mode と通常モードの切り替えコマンド"
  (interactive)
  (cond (view-mode
         (hl-line-mode -1)
         (view-mode -1))
        (t
         (hl-line-mode 1)
         (view-mode 1))))
```
