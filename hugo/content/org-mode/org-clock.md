+++
title = "org-clock"
draft = false
weight = 6
+++

## 概要 {#概要}

org-clock 関係の設定をここにまとめている


## clocktable の設定 {#clocktable-の設定}

clocktable は report 表示などで使う表の設定。

```emacs-lisp
(setq org-clock-clocktable-default-properties
      '(:maxlevel 10
                 :lang "ja"
                 :scope agenda-with-archives
                 :block today
                 :level 4))
```

| 項目名   | 設定内容                                |
|-------|-------------------------------------|
| maxlevel | ツリーの何段目まで表示するかの設定。隠さないで欲しいので大きい値を指定している |
| lang     | 日本語ネイティブなので日本語で          |
| scope    | agenda とそのアーカイブもチェック。結構するアーカイブするので |
| block    | 基本的に退勤前に実行するので today にしている |
| level    | 最低限表示するレベル。まあ適当          |


## hooks {#hooks}


### clock-in 時の hook {#clock-in-時の-hook}

clock-in のタイミングで以下の処理をするための hook を用意している

-   作業開始したことを Slack 通知する
-   TODO ステータスを DOING に変更

<!--listend-->

```emacs-lisp
(defun my/org-clock-in-hook ()
  (let* ((task org-clock-current-task)
         (message (format "開始: %s" task)))
    (my/notify-slack-times message))

  (if (org-clocking-p)
      (org-todo "DOING")))

(setq org-clock-in-hook 'my/org-clock-in-hook)
```


### clock-out 時の hook {#clock-out-時の-hook}

clock-out のタイミングで以下の処理をするための hook を用意している

-   作業終了を Slack 通知する
    -   中断でも終了扱いになるのでちょっと悩み中。DONE にしたことを hook する必要があるかも。

<!--listend-->

```emacs-lisp
(defun my/org-clock-out-hook ()
  (let* ((task org-clock-current-task)
         (message (format "終了: %s" task)))
    (my/notify-slack-times message)))

(setq org-clock-out-hook 'my/org-clock-out-hook)
```


## org-pomodoro {#org-pomodoro}

ポモドーロテクニックを使うために org-pomodoro を導入している

```emacs-lisp
(el-get-bundle org-pomodoro)
```

そして以下の設定をしている

-   sound は結構邪魔なのでそれは鳴らないようにしている
-   デフォルトの 25 分だと短かいので倍の 50 分にしている
    -   25 分だとノって来た時に終わるので集中できない
-   それに合わせて short break も倍にしている
    -   10 分休めると間で色々できて便利。Emacs のパッケージ更新とか。
-   long break も通常の 1.5 倍にしている
    -   とはいえ long break になる頃は定時が近いので無視しがち

<!--listend-->

```emacs-lisp
(custom-set-variables
 '(org-pomodoro-play-sounds nil)
 '(org-pomodoro-length 50)
 '(org-pomodoro-short-break-length 10)
 '(org-pomodoro-long-break-length 30))
```

今のところこの運用で大体うまくいってて良い
