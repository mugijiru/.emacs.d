+++
title = "fullscreen"
draft = false
+++

## 概要 {#概要}

起動時にフルスクリーンにする設定はここにまとめている


## Mac の設定 {#mac-の設定}

Mac の場合にフルスクリーンにする設定を入れていた。けど 2020-01-08 に yabai WM を導入したことにより起動時はフルスクリーンじゃない方がよくなったので以下の処理は今は使ってない。

```emacs-lisp
(if (or (eq window-system 'ns) (eq window-system 'mac))
    (add-hook 'window-setup-hook
              (lambda ()
                (set-frame-parameter nil 'fullscreen 'fullboth))))
```


## Linux(X Window system) の設定 {#linux--x-window-system--の設定}

X Window system の場合にはフルスクリーンにする。まあ Linux って書いているけど WSL2 用なのである。

```emacs-lisp
(if (eq window-system 'x)
    (add-hook 'window-setup-hook
              (lambda ()
                (set-frame-parameter nil 'fullscreen 'fullboth)
                (set-frame-position nil 0 0))))
```

微妙に画面の下の方がちゃんとフルになってくれてないけどそこは今は我慢して使っている。
