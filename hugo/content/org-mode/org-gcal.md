+++
title = "org-gcal"
tags = ["replacement"]
draft = false
weight = 8
+++

## 概要 {#概要}

[org-gcal](https://github.com/kidd/org-gcal.el) は org-mode と Google Calendar を連携させるためのパッケージ。

オリジナルは <https://github.com/myuhe/org-gcal.el> なのだけど今は fork されてるやつが MELPA にも登録されていて
el-get のレシピもそっちを見ている。


## インストール {#インストール}

org-gcal が依存しているので [parsist](https://elpa.gnu.org/packages/persist.html) を入れている。

```emacs-lisp
(el-get-bundle persist)
```

あとは当然 org-gcal 本体を入れないと動かない

```emacs-lisp
(el-get-bundle org-gcal)
```

その際 el-get のレシピは自前で用意している

```emacs-lisp
(:name org-gcal
       :description "Org sync with Google Calendar."
       :website "https://github.com/kidd/org-gcal.el"
       :type github
       :minimum-emacs-version "26"
       :depends (request alert cl-lib aio)
       :pkgname "kidd/org-gcal.el")
```

`emacs-aio` も recipe を自前で用意している

```emacs-lisp
(:name aio
       :website "https://github.com/skeeto/emacs-aio"
       :description "aio is to Emacs Lisp as asyncio is to Python."
       :type github
       :pkgname "skeeto/emacs-aio")
```

のだけど確か org-gcal のレシピは修正されているし emacs-aio も recipe 追加されてたはずなので多分これは el-get 本体のものに切り替えても良いはず……


## 設定 {#設定}

まずは org-gcal の設定が authinfo から読み込まれるようにする

```emacs-lisp
(custom-set-variables
 '(org-gcal-client-id (plist-get (nth 0 (auth-source-search :host "googleusercontent.com")) :client))
 '(org-gcal-client-secret (funcall (plist-get (nth 0 (auth-source-search :host "googleusercontent.com" :max 1)) :secret))))
```

そして org-gcal 本体を require する。

```emacs-lisp
(require 'org-gcal)
```

あとは passphrase を保存できるようにした方が良いみたいなのが確か README に比較的最近追加されたのでそれを入れている

```emacs-lisp
(setq plstore-cache-passphrase-for-symmetric-encryption t)
```

あとは設定ファイルは公開したくないので別ファイルに分けてる。

```emacs-lisp
(my/load-config "my-org-gcal-config")
```

隠したい部分だけ .authinfo.gpg にでも分離したら公開できるようになるかもしれない。


## appt {#appt}

Emacs にはデフォルトで約束の通知ができる機能が appt.el で定義されている。
org-gcal で取得したデータをそれで通知できるように
appt の設定をここで行っている


### 通知形式の設定 {#通知形式の設定}

window 通知を使う設定にしている。

```emacs-lisp
(setq appt-display-format 'window)
```

これだけだと、通知する時間になったらピョコッと window が生えて来るのだけど、後の方で、この設定の時に使う関数を差し替えている


### 通知用関数の定義 {#通知用関数の定義}

通知には [alert.el]({{< relref "alert" >}}) を使いたいので自前で関数を定義。
alert.el は別のところで設定していてそこで dunst を使って通知するようにしている。

```emacs-lisp
(defun my/appt-alert (min-to-app _new-time msg)
  (interactive)
  (let ((title (format "あと %s 分" min-to-app)))
    (alert msg :title title)))
```

この関数を使うように `appt-disp-window-function` を変更している。

```emacs-lisp
(setq appt-disp-window-function 'my/appt-alert)
```

最後に org-gcal でカレンダーを取得した後に appt に登録されるように advice を設定した

```emacs-lisp
(advice-add #'org-gcal--sync-unlock :after #'my/org-refresh-appt)
```


## その他 {#その他}

[gcal-org](https://github.com/misohena/gcal) に乗り換えようかと思ってるがそっちの中身もよくわからないので躊躇している。自分の用途に合うのだろうか?
