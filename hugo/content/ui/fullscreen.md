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


## WSL の設定 {#wsl-の設定}

X Window system の場合かつ WSLENV という環境変数が設定されている場合にはフルスクリーンにする。新しく Linux マシンを導入したらこれの影響を受けていたので後から WSLENV による判定を追加した次第。

```emacs-lisp
(if (and (eq window-system 'x) (getenv "WSLENV"))
    (add-hook 'window-setup-hook
              (lambda ()
                (set-frame-parameter nil 'fullscreen 'fullboth)
                (set-frame-position nil 0 0))))
```

微妙に画面の下の方がちゃんとフルになってくれてないけどそこは今は我慢して使っている。ちなみにその病はどうやら WSLg になっても残りそう。
<https://w.atwiki.jp/ntemacs/pages/69.html>
