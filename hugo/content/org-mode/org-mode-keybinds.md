+++
title = "org-mode 関係の keybinds"
draft = false
weight = 14
+++

## 概要 {#概要}

ここでは org-mode 関係のキーバインド設定を書いている。キーバインドというか Hydra の設定になっているが。

Hydra を定義しておくことで様々なキーバインドを忘れることができるし左手小指を酷使しなくて済むので便利ということで Hydra で設定している。


## major-mode-hydra {#major-mode-hydra}

major-mode-hydra で、org-mode のファイルを開いている時によく使いそうなコマンドのキーバインドを定義している

```emacs-lisp
(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define org-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-fileicon "org") " Org commands"))
    ("Navigation"
     (("H" counsel-outline "Outline"))

     "Insert"
     (("l" org-insert-link                     "Link")
      ("T" org-insert-todo-heading             "Todo")
      ("h" org-insert-heading-respect-content  "Heading")
      ("P" org-set-property                    "Property")
      ("." org-time-stamp                      "Timestamp")
      ("!" org-time-stamp-inactive             "Timestamp(inactive)")
      ("S" org-insert-structure-template       "Snippet"))

     "Edit"
     (("a" org-archive-subtree  "Archive")
      ("r" org-refile           "Refile")
      ("Q" org-set-tags-command "Tag"))

     "View"
     (("N" org-toggle-narrow-to-subtree "Toggle Subtree")
      ("C" org-columns "Columns")
      ("O" org-global-cycle "Toggle open")
      ("D" my/org-clock-toggle-display  "Toggle Display"))

     "Task"
     (("s" org-schedule         "Schedule")
      ("d" org-deadline         "Deadline")
      ("t" my/org-todo          "Change state")
      ("c" org-toggle-checkbox  "Toggle checkbox"))

     "Clock"
     (("i" org-clock-in      "In")
      ("o" org-clock-out     "Out")
      ("E" org-set-effort    "Effort")
      ("R" org-clock-report  "Report")
      ("p" org-pomodoro      "Pomodoro"))

     "Babel"
     (("e" org-babel-confirm-evaluate "Eval")
      ("x" org-babel-tangle "Export SRC"))

     "Trello"
     (("K" org-trello-mode "On/Off" :toggle org-trello-mode)
      ("k" (if org-trello-mode
               (org-trello-hydra/body)
             (message "org-trello-mode is not enabled")) "Menu"))

     "Agenda"
     (("," org-cycle-agenda-files "Cycle"))))

  (major-mode-hydra-define org-agenda-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-octicon "calendar") " Agenda commands"))
    ("Edit"
     (("a" org-agenda-archive  "Archive")
      ("r" org-agenda-refile   "Refile")
      ("t" org-agenda-todo     "TODO")
      ("Q" org-agenda-set-tags "Tag"))

     "Filter"
     (("C" org-agenda-filter-by-category     "Category")
      ("T" org-agenda-filter-by-tag          "Tag")
      ("H" org-agenda-filter-by-top-headline "Headline")
      ("E" org-agenda-filter-by-effort       "Effort")
      ("R" org-agenda-filter-by-regex        "Regex")
      ("z" org-agenda-filter-remove-all      "Clear"))

     "Priority"
     ((">" org-agenda-priority-up   "Up")
      ("<" org-agenda-priority-down "Down")
      ("," org-agenda-priority      "Set"))

     "Clock"
     (("i" org-agenda-clock-in     "In")
      ("o" org-agenda-clock-out    "Out")
      ("p" org-pomodoro            "Pomodoro")
      ("e" org-agenda-set-effort   "Set Effort")
      ("g" org-agenda-clock-goto   "Go to")
      ("x" org-agenda-clock-cancel "Cancel")))))
```

| Key | 効果                        | 使用頻度                            |
|-----|---------------------------|---------------------------------|
| l   | リンク挿入                  | C-c C-l で手が馴染んでるのでたまに使う程度 |
| T   | TODO ヘッドライン挿入       | なんかあまり使わない                |
| h   | ヘッドライン挿入            | これも C-RET で慣れてるので使ってない |
| P   | プロパティ設定              | よく使う                            |
| .   | タイムスタンプ挿入          | 使ってない。使い慣れると便利かも    |
| !   | アジェンダのエントリに反映されないタイムスタンプ挿入 | 使ってない。こっちも慣れると便利かも? |
| S   | &lt;s TAB とかのテンプレートの挿入 | 使ってないなあ。慣れたら便利かも    |
| a   | サブツリーをアーカイブ      | よく使う                            |
| r   | サブツリーの移動(refile)    | よく使う                            |
| Q   | タグ設定                    | 時々使う。C-c C-q の方が使うか      |
| N   | カーソル位置のサブツリーのみ表示 | 使ってない。そのツリーだけに集中することがないのかも |
| C   | カラム表示。ツリー内の時間などを合計して表示できる | たまに使う。                        |
| D   | 各ツリーでそれぞれの掛かった時間を表示 | 使ってない。存在忘れてた            |
| s   | スケジュール設定            | C-c C-s をよく使う                  |
| d   | 締め切り設定                | C-c C-d をよく使う                  |
| t   | TODO ステータス変更         | 同じ効果である C-c C-t と同じぐらい使う |
| c   | チェックボックスの切替      | 使うけどチェックボックスの行だけ使えればいいよなとか思う |
| i   | Clock In                    | よく使う。標準的なキーバインドは忘れた。 |
| o   | Clock Out                   | よく使う。標準的なキーバインドは忘れた。 |
| E   | 見積時間の挿入              | まあまあ使う。設定して予実差の確認はできてない |
| R   | org-clock のレポート挿入    | 一応毎日の稼動をこれで記録している  |
| p   | ポモドーロタイマーの開始    | ポモドーロテクニック使えてないでござる |
| e   | org-babel のコード片を実行  | C-c C-c しか使ってない気がするお    |
| x   | tangle でファイル出力       | 最近多用している                    |
| K   | org-trello-mode の切替      | 最近使ってない。trello 連携してないバッファでは要らんしな |
| k   | org-trello-mode 用の Hydra 起動 | 同上                                |
| ,   | agenda ファイルの移動       | いつも固定のファイルを見てるので使ってない。Cycle より直で飛ぶし |

合わせて agenda 用の major-mode-hydra も定義しているが、こちらは情報をまだまとめていない……。


## Global な Hydra {#global-な-hydra}

pretty-hydra を使って Global に使える org-mode のコマンドを叩けるようにしている

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define
    global-org-hydra
    (:separator "-"
                :color teal
                :foreign-key warn
                :title (concat (all-the-icons-fileicon "org") " Global Org commands")
                :quit-key "q")
    ("Main"
     (("a" org-agenda                 "Agenda")
      ("c" counsel-org-capture        "Capture")
      ("l" org-store-link             "Store link")
      ("J" org-journal-new-entry      "Journal")
      ("R" my/org-reviews-execute     "Review")
      ("t" my/org-tags-view-only-todo "Tagged Todo"))

     "Calendar"
     (("F" org-gcal-fetch "Fetch Calendar")
      ("C" my/open-calendar "Calendar")
      ("A" my/org-refresh-appt "Appt"))

     "Clock"
     (("i" org-clock-in       "In")
      ("o" org-clock-out      "Out")
      ("r" org-clock-in-last  "Restart")
      ("x" org-clock-cancel   "Cancel")
      ("j" org-clock-goto     "Goto"))

     "Search"
     (("H" org-search-view "Heading")
      ("O" counsel-org-goto-all "Outline"))

     "Roam"
     ((";" org-roam-hydra/body "Menu"))

     "Pomodoro"
     (("p" org-pomodoro "Pomodoro")))))
```

| Key | 効果                        | 使用頻度                                      |
|-----|---------------------------|-------------------------------------------|
| a   | Agenda 選択                 | よく使う                                      |
| c   | Capture                     | よく使う                                      |
| l   | その場所へのリンクを保存    | 使ってない                                    |
| t   | 選択したタグが付与された TODO のみ表示 | 使ってない。使うと便利かもなあ                |
| F   | Google Calendar の情報取得  | 平日は毎日使っている                          |
| C   | カレンダーを calfw で開く   | 最近使ってない                                |
| A   | org-gcal で拾って来た情報を appt に登録 | appt.el 経由で通知できるようにしている        |
| i   | Clock In                    | 使ってないというか major-mode-hydra の方があれば良い |
| o   | Clock Out                   | 使ってない。使ってもいい気がする              |
| r   | 最後に Clock In したやつを再開 | 使ってない。大体常に Clock しているから最後がいつも切り替わってるので使う機会がない |
| x   | Clock Cancel                | 作業は発生しているからキャンセルしないで普通に Clock out しているなあ |
| j   | 最後に Clock In したやつの場所に移動 | ちょくちょく使う。便利                        |
| H   | Heading の検索              | 使ってない。インクリメンタルに検索できればいいのに |
| p   | ポモドーロタイマー          | これも major-mode-hydra にあれば十分かな      |


## その他 {#その他}

org-agenda 用の Hydra も用意しておいた方が良さそうだなというのが最近の実感。同じコマンド体系で操作できるようにしておいたら考えることが減って楽。
