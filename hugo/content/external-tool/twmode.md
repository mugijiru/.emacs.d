+++
title = "twmode"
draft = false
+++

## 概要 {#概要}

[twmode](https://github.com/hayamiz/twittering-mode) は Emacs 上で動く Twitter クライアント。

今でもたまーに使っている。勉強会に参加して実況する時などに。


## インストール {#インストール}

いつも通り el-get でインスコしている。

```emacs-lisp
(el-get-bundle twittering-mode)
```


## 設定 {#設定}

```emacs-lisp
(setq twittering-username "mugijiru")
(setq twittering-jojo-mode t)
(setq twittering-timer-interval 60)
;(setq twittering-auth-method 'xauth)
(setq twittering-auth-method 'oauth)
(setq twittering-update-status-function 'twittering-update-status-from-minibuffer)
(setq twittering-status-format "%i %S(%s)%p, %@:\n%FILL{  %T // from %f%L%r%R}\n ")
(setq twittering-retweet-format "RT @%s %t")
(setq twittering-display-remaining t)
```

なんか色々設定しているけど、まあ大体こんな感じ。

-   ユーザー名の指定
-   twittering-jojo-mode を有効化
-   自動リロードの間隔を60秒に設定
-   OAuth で認証するように設定
-   投稿時にミニバッファから投稿するように設定
-   各ツイートのフォーマット指定
-   旧式の Retweet 時のフォーマット指定
-   late limit をmode-line に表示


## キーバインド {#キーバインド}

```emacs-lisp
(let ((km twittering-mode-map))
  (define-key km (kbd "SPC") 'scroll-up)
  (define-key km (kbd "b") 'scroll-down)
  (define-key km (kbd "g") 'beginning-of-buffer)
  (define-key km (kbd "G") 'end-of-buffer)
  (define-key km (kbd "<") 'beginning-of-buffer)
  (define-key km (kbd ">") 'end-of-buffer)
  (define-key km (kbd "R") 'twittering-current-timeline)
  (define-key km (kbd "F") 'twittering-favorite)
  (define-key km (kbd "\C-cfd") 'twittering-unfavorite)
  (define-key km (kbd "\C-c[") 'twittering-follow)
  (define-key km (kbd "\C-c]") 'twittering-unfollow)
  nil)
```

| Key     | 効果         |
|---------|------------|
| SPC     | スクロールする |
| b       | 上にスクロールする |
| g, <    | バッファの先頭に移動 |
| G, >    | バッファの末尾に移動 |
| R       | 現在のタイムラインを更新 |
| F       | ふぁぼる     |
| C-c f d | ふぁぼ取り消し |
| C-c [   | フォローする |
| C-c ]   | アンフォロー |
