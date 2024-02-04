+++
title = "Agenda 関係の設定"
draft = false
weight = 4
+++

## 概要 {#概要}

org-mode の素晴らしい機能の1つに Agenda というものがある。

これは色々な org ファイルに散らばった情報を1つのビューに表示するための機能で、使いこなすとファイルがバラけていてもいい感じに情報が抽出できて便利なやつ。

まあ麦汁さんはまだ使いこなせてないけど。

それでもいくつか Agenda 用の View を用意したりして日常業務に役立てている。


## org-super-agenda のインストール {#org-super-agenda-のインストール}

org-mode のデフォルトの agenda だと表示周りが物足りなかったので
[org-super-agenda](https://github.com/alphapapa/org-super-agenda) を導入している。

```emacs-lisp
(el-get-bundle org-super-agenda)
```


## 週の始まりを日曜日に設定 {#週の始まりを日曜日に設定}

麦汁さんは週のスタートを日曜日とする派なので
org-agenda の週の始まりも日曜日に設定している

```emacs-lisp
(setq org-agenda-start-on-weekday 0)
```


## 1日単位をデフォルト表示に設定 {#1日単位をデフォルト表示に設定}

1週間表示よりも「今日って何するんだっけ」みたいな使い方が多いので
1日を表示単位としている。

```emacs-lisp
(setq org-agenda-span 'day)
```

週単位で何をするかについては今のところ記憶力で対応している。

あと、基本的にカスタムビューを使ってるのでこれの影響は受けてるかどうか微妙。


## agenda の対象ファイルを指定 {#agenda-の対象ファイルを指定}

org-agenda を使う時に抽出対象とする org ファイルを指定している。

```emacs-lisp
(custom-set-variables
 '(org-agenda-files '("~/Documents/org/gcals/mugijiru.org" "~/Documents/org/tasks/")))
```


## agenda の表示周りの設定 {#agenda-の表示周りの設定}


### agenda に時間の区切りを入れない {#agenda-に時間の区切りを入れない}

`org-agenda-use-time-grid` を t にしていると
10:00 とかのキリがいいところに区切り線を表示してくれるのだが日報提出時には邪魔だし、普段使いでもその区切り線はあっても邪魔っぽいので
nil にして表示しないようにしている。

```emacs-lisp
(setq org-agenda-use-time-grid nil)
```


### ブロック間の区切り表示 {#ブロック間の区切り表示}

ブロックとブロックの区切りをハイフン繋ぎの文字列で指定している。

文字列を指定することで固定の長さの区切り文字になるが実は `?-` とか指定して長さが無限に伸びるようにしてもいいかもしれない。と思いつつ、多分 zoom-mode とかでバッファの幅が切り替わる時に邪魔になるから固定でいいか。

```emacs-lisp
(setq org-agenda-block-separator "------------------------------")
```


### org-super-agnda-mode の有効化 {#org-super-agnda-mode-の有効化}

なんでここで有効化しているのかね。インストールのやつと近付けた方がいい気がする。

とりあえず有効化して使えるようにしている。

```emacs-lisp
(org-super-agenda-mode 1)
```


### agenda で使う変数の初期化 {#agenda-で使う変数の初期化}

`my/org-agenda-calendar-files` という変数でカレンダーの情報を取り込んで agenda を表示できるようにしている。けど今はカレンダー連携をしていないので空で初期化している。

```emacs-lisp
(setq my/org-agenda-calendar-files '())
```


### カスタムビュー {#カスタムビュー}

色々なカスタムビューを定義している。かといって全部使ってるわけではないし、つまり使いこなせているかというと微妙。

| キー | 内容                           | 備考                                 |
|----|------------------------------|------------------------------------|
| hs | 稼動日の始業直後に実施する習慣タスクの表示 | よく使っている。その日やるタスクを決めたりしている |
| hf | 稼動日の退勤直前に実施する習慣タスクの表示 | よく使っている。その日の日報を書くなどしている |
| hw | 週間隔または隔週で実施する習慣タスクの表示 | 週1で使う感じ。この中に放置しているタスクもある |
| hh | 休日の習慣タスク               | 最近使ってない。。。真面目にタスクを作り過ぎてだるくなってるやつ |
| d  | 今日の予定などを表示           | 普段は会議部分しか見てないので改善が必要そう |
| D  | 休日タスクの表示               | 使ってない。。。                     |
| pp | GTD の Projects の表示         | たまに使う程度。もうちょっと洗練させたい |
| pP | GTD の Projects の内、環境整備系以外 | 環境整備はやっても業務に直接寄与しないので忙しい時は見たくないでござる |
| P  | GTD の Pointers の表示         | たまーに使う。資料が貯まり過ぎて取り扱いに困っている |
| X  | 終了したタスクを表示           | まとめてお掃除する時に使っている     |
| z  | 日報用表示                     | 毎日業務日報の提出が要求されているのでそれっぽく表示されるようにしている |
| H  | GTD の Projects の中の家事を抽出 | 最近は使ってない                     |
| EO | org-mode 関連の環境整備タスク  | 最近見てない                         |
| EE | Emacs 関係かつ org-mode 以外の環境整備タスク | 貯まる一方                           |
| Ee | Emacs 以外の環境整備タスク     | これも貯まる。Emacs 設定ほどじゃないけど |

```emacs-lisp
(custom-set-variables
 '(org-agenda-custom-commands
   '(("h" . "Habits")
     ("hs" "Weekday Start"
      ((tags "Weekday&Start|Daily"
             ((org-agenda-prefix-format "  ")
              (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                         (:name "今日の作業" :scheduled today)
                                         (:discard (:anything t))))))))
     ("hf" "Weekday Finish"
      ((tags "Weekday&Finish"
             ((org-agenda-prefix-format "  ")
              (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                         (:name "今日の作業" :scheduled today)
                                         (:discard (:anything t))))))))
     ("hw" "Weekly"
      ((tags "Weekly"
             ((org-agenda-prefix-format "  ")
              (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                         (:name "今週の作業" :scheduled today)
                                         (:discard (:anything t))))))))
     ("hh" "Holiday"
      ((tags "Weekend|Holiday|Daily"
             ((org-agenda-prefix-format "  ")
              (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                         (:name "今日の作業" :scheduled today)
                                         (:discard (:anything t))))))))
     ("d" "Today"
      ((agenda "会議など"
               ((org-agenda-span 'day)
                (org-agenda-files my/org-agenda-calendar-files)))
       (tags-todo "-Weekday-Daily-Holiday-Weekly-Weekend"
                  ((org-agenda-prefix-format " ")
                   (org-agenda-overriding-header "今日の作業")
                   (org-habit-show-habits nil)
                   (org-agenda-span 'day)
                   (org-agenda-prefix-format "%l%c: ")
                   (org-agenda-files '("~/Documents/org/tasks/habits.org"
                                       "~/Documents/org/journal/"
                                       "~/Documents/org/tasks/reviews.org"))
                   (org-super-agenda-groups '((:name "仕掛かり中" :todo "DOING" :property ("agenda-group" "journal-task"))
                                              (:name "TODO" :and (:todo "TODO" :property ("agenda-group" "journal-task")))
                                              (:name "レビュー中" :todo "DOING" :category "レビュー")
                                              (:name "レビュー待ち" :todo "WAIT" :property ("agenda-group" "journal-task"))
                                              (:name "修正待ち" :todo "WAIT" :category "レビュー")
                                              (:discard (:anything t))))))
       (alltodo ""
                ((org-agenda-prefix-format " ")
                 (org-agenda-overriding-header "予定業務")
                 (org-habit-show-habits nil)
                 (org-agenda-span 'day)
                 (org-agenda-prefix-format "  %c: ")
                 (org-agenda-files '("~/Documents/org/tasks/projects.org"))
                 (org-super-agenda-groups `((:name "〆切が過ぎてる作業" :and (:deadline past   :property ("agenda-group" "1. Work")))
                                            (:name "予定が過ぎてる作業" :and (:scheduled past  :property ("agenda-group" "1. Work")))
                                            (:name "今日〆切の作業"     :and (:deadline today  :property ("agenda-group" "1. Work")))
                                            (:name "今日予定の作業"     :and (:scheduled today :property ("agenda-group" "1. Work")))
                                            (:name "今後1週間の作業"    :and (:and
                                                                              (:scheduled (before ,(format-time-string "%Y-%m-%d" (time-add (current-time) (days-to-time 7))))
                                                                                          :scheduled (after ,(format-time-string "%Y-%m-%d" (current-time))))
                                                                              :property ("agenda-group" "1. Work")))
                                            (:discard (:anything t))))))
       (tags-todo "Weekday-Finish|Daily"
                  ((org-agenda-overriding-header "習慣")
                   (org-agenda-prefix-format "  ")
                   (org-habit-show-habits t)
                   (org-agenda-files '("~/Documents/org/tasks/habits.org"))
                   (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                              (:name "今日予定" :scheduled today)
                                              (:discard (:anything t))))))

       (tags-todo "LEVEL=2"
                  ((org-agenda-files '("~/Documents/org/tasks/projects.org"))
                   (org-agenda-overriding-header "予定なし")
                   (org-super-agenda-groups '((:and (:property ("agenda-group" "1. Work") :scheduled nil :deadline nil))
                                              (:discard (:anything t))))))))
     ("D" "Holiday"
      ((tags-todo "-Weekday-Daily-Holiday-Weekly-Weekend&LEVEL=3"
                  ((org-agenda-prefix-format " ")
                   (org-agenda-overriding-header "休日の作業")
                   (org-habit-show-habits nil)
                   (org-agenda-prefix-format "  %c: ")
                   (org-agenda-span 'day)
                   (org-agenda-files '("~/Documents/org/journal/"))
                   (org-super-agenda-groups '((:name "仕掛かり中" :and (:todo "DOING" :not (:property ("agenda-group" "1. Work"))))
                                              (:name "TODO"       :and (:todo "TODO"  :not (:property ("agenda-group" "1. Work"))))
                                              (:name "待ち"       :and (:todo "WAIT"  :not (:property ("agenda-group" "1. Work"))))
                                              (:discard (:anything t))))))
       (alltodo ""
                ((org-agenda-prefix-format " ")
                 (org-agenda-overriding-header "予定作業")
                 (org-habit-show-habits nil)
                 (org-agenda-prefix-format "  %c: ")
                 (org-agenda-span 'day)
                 (org-agenda-files '("~/Documents/org/tasks/projects.org" "~/Documents/org/tasks/inbox.org"))
                 (org-super-agenda-groups `((:name "〆切が過ぎてる作業" :and (:deadline past   :not (:property ("agenda-group" "1. Work"))))
                                            (:name "予定が過ぎてる作業" :and (:scheduled past  :not (:property ("agenda-group" "1. Work"))))
                                            (:name "今日〆切の作業"     :and (:deadline today  :not (:property ("agenda-group" "1. Work"))))
                                            (:name "今日予定の作業"     :and (:scheduled today :not (:property ("agenda-group" "1. Work"))))
                                            (:name "今後1週間の作業"    :and (:and
                                                                              (:scheduled (before ,(format-time-string "%Y-%m-%d" (time-add (current-time) (days-to-time 7))))
                                                                                          :scheduled (after ,(format-time-string "%Y-%m-%d" (current-time))))
                                                                              :not (:property ("agenda-group" "1. Work"))))
                                            (:discard (:anything t))))))
       (tags-todo "Holiday|Weekend|Daily"
                  ((org-agenda-overriding-header "習慣")
                   (org-agenda-prefix-format "  ")
                   (org-agenda-files '("~/Documents/org/tasks/habits.org"))
                   (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                              (:name "今日予定の作業" :scheduled today)
                                              (:discard (:anything t))))))
       (tags-todo "LEVEL=2"
                  ((org-agenda-files '("~/Documents/org/tasks/projects.org"))
                   (org-agenda-overriding-header "Private")
                   (org-super-agenda-groups '((:name "Priority >= B" :and (:priority>= "B" :property ("agenda-group" "7. Private")))
                                              (:name "no priority" :and (:not (:priority>= "C") :property ("agenda-group" "7. Private")))
                                              (:discard (:anything t))))))
       (tags-todo "Emacs&LEVEL=2"
                  ((org-agenda-files '("~/Documents/org/tasks/projects.org"))
                   (org-agenda-overriding-header "Emacs")
                   (org-super-agenda-groups '((:priority>= "B")
                                              (:name "no priority" :not (:priority>= "C"))
                                              (:discard (:anything t))))))
       (tags-todo "Env&LEVEL=2"
                  ((org-agenda-files '("~/Documents/org/tasks/projects.org"))
                   (org-agenda-overriding-header "Env")
                   (org-super-agenda-groups '((:priority>= "B")
                                              (:name "no priority" :not (:priority>= "C"))
                                              (:discard (:anything t))))))))

     ("p" . "Projects")
     ("pA" "Projects Priority A"
      ((tags-todo "LEVEL=2&PRIORITY=\"A\"" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))
     ("pc" "Category"
      ((tags-todo "LEVEL=2&CATEGORY=\"Work\"" ((org-agenda-overriding-header "お仕事タスク")
                                               (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                               (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Housework\"" ((org-agenda-overriding-header "家事")
                                                    (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                                    (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Config\"" ((org-agenda-overriding-header "設定弄り")
                                                 (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                                 (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Research\"" ((org-agenda-overriding-header "調査")
                                                   (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                                   (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Indie hack\"" ((org-agenda-overriding-header "個人開発")
                                                     (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                                     (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Hoby\"" ((org-agenda-overriding-header "趣味関係")
                                               (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                               (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Private\"" ((org-agenda-overriding-header "Private タスク")
                                                  (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                                  (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))))

     ("pC" "Category auto"
      ((tags-todo "LEVEL=2" ((org-agenda-overriding-header "Categories")
                             (org-agenda-files `(,(concat org-directory "tasks/projects.org")))
                             (org-super-agenda-groups '((:auto-category t)))))))
     ("pg" "Agenda groups"
      ((tags-todo "LEVEL=2" ((org-agenda-overriding-header "Categories")
                             (org-agenda-files `(,(concat org-directory "tasks/projects.org")))
                             (org-super-agenda-groups '((:auto-group t)))))))
     ("pp" "Projects"
      ((tags-todo "LEVEL=2" ((org-agenda-prefix-format " ")
                             (org-agenda-overriding-header "今日のタスク")
                             (org-habit-show-habits nil)
                             (org-agenda-span 'day)
                             (org-agenda-todo-keyword-format "-")
                             (org-agenda-files '("~/Documents/org/tasks/habits.org" "~/Documents/org/journal/"))
                             (org-super-agenda-groups (append
                                                       (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DOING" "WAIT")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                                       '((:name "その他" :scheduled nil)
                                                         (:discard (:anything t)))))))
       (tags-todo "LEVEL=2" ((org-agenda-prefix-format " ")
                             (org-agenda-overriding-header "予定に入ってる作業")
                             (org-habit-show-habits nil)
                             (org-agenda-span 'day)
                             (org-agenda-todo-keyword-format "-")
                             (org-agenda-files '("~/Documents/org/tasks/projects.org"))
                             (org-super-agenda-groups '((:name "〆切が過ぎてる作業" :deadline past)
                                                        (:name "予定が過ぎてる作業" :scheduled past)
                                                        (:name "今日〆切の作業" :deadline today)
                                                        (:name "今日予定の作業" :scheduled today)
                                                        (:discard (:anything t))))))
       (tags-todo "LEVEL=2" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))
                             (org-super-agenda-groups '((:name "待ち" :todo "WAIT")
                                                        (:name "仕掛かり中" :todo "DOING")
                                                        (:name "TODO" :todo "TODO")
                                                        (:discard (:anything t))))))))
     ("pP" "Projects without Env"
      ((alltodo "" ((org-agenda-prefix-format " ")
                    (org-agenda-overriding-header "今日のタスク")
                    (org-habit-show-habits nil)
                    (org-agenda-span 'day)
                    (org-agenda-todo-keyword-format "-")
                    (org-agenda-files '("~/Documents/org/tasks/habits.org" "~/Documents/org/journal/"))
                    (org-super-agenda-groups (append
                                              (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DOING" "WAIT")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                              '((:name "その他" :scheduled nil)
                                                (:discard (:anything t)))))))
       (alltodo "" ((org-agenda-prefix-format " ")
                    (org-agenda-overriding-header "予定に入ってる作業")
                    (org-habit-show-habits nil)
                    (org-agenda-span 'day)
                    (org-agenda-todo-keyword-format "-")
                    (org-agenda-files '("~/Documents/org/tasks/projects.org"))
                    (org-super-agenda-groups '((:name "〆切が過ぎてる作業" :deadline past)
                                               (:name "予定が過ぎてる作業" :scheduled past)
                                               (:name "今日〆切の作業" :deadline today)
                                               (:name "今日予定の作業" :scheduled today)
                                               (:discard (:anything t))))))
       (tags-todo "-Emacs-org-Env-Hugo&LEVEL=2" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))
     ("pN" "No major tags"
      ((tags-todo "-Emacs-org-Env-Hugo-Kibela-Develop-ReviewLister-HouseWork-Private&LEVEL=2" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))
     ("P" "Pointers"
      ((todo "DOING" ((org-agenda-files '("~/Documents/org/tasks/pointers.org"))))
       (todo "TODO"  ((org-agenda-files '("~/Documents/org/tasks/pointers.org"))))))
     ("X" "Finished"
      ((tags "LEVEL=2" ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                            "~/Documents/org/tasks/inbox.org"
                                            "~/Documents/org/tasks/reviews.org"
                                            "~/Documents/org/journal/"
                                            "~/Documents/org/tasks/habits.org"))
                        (org-super-agenda-groups '((:name "Finished" :todo "DONE")
                                                   (:name "Someday" :todo "SOMEDAY")
                                                   (:discard (:anything t))))))))

     ("z" "日報"
      ((agenda "" ((org-agenda-span 'day)
                   (org-agenda-overriding-header "")
                   (org-habit-show-habits nil)
                   (org-agenda-format-date "## %Y/%m/%d (%a) 日報")
                   (org-agenda-prefix-format " %?-12t")
                   (org-agenda-files my/org-agenda-calendar-files)
                   (org-super-agenda-groups
                    '((:name "会議など" :time-grid t)
                      (:discard (:anything t))))))
       (todo "DONE" ((org-agenda-prefix-format " ")
                     (org-agenda-overriding-header "対応済")
                     (org-habit-show-habits nil)
                     (org-agenda-span 'day)
                     (org-agenda-todo-keyword-format "-")
                     (org-columns-default-format-for-agenda "%25ITEM %TODO %3PRIORITY")
                     (org-agenda-files '("~/Documents/org/tasks/habits.org" "~/Documents/org/journal/"))
                     (org-super-agenda-groups (append
                                               (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DONE")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                               '((:discard (:anything t :name "discard")))))))
       (alltodo "" ((org-agenda-prefix-format " ")
                    (org-agenda-overriding-header "仕掛かり中")
                    (org-habit-show-habits nil)
                    (org-agenda-span 'day)
                    (org-agenda-todo-keyword-format "-")
                    (org-agenda-files '("~/Documents/org/tasks/habits.org" "~/Documents/org/journal/"))
                    (org-super-agenda-groups (append
                                              (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DOING" "WAIT")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                              '((:discard (:anything t :name "discard")))))))))

     ("H" "HouseWork" ((tags "HouseWork")))
     ("E" . "Env")
     ("EO" "org"
      ((tags-todo "+org"
                  ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                       "~/Documents/org/tasks/inbox.org"))))))
     ("EE" "Emacs without org"
      ((tags-todo "+Emacs-org"
                  ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                       "~/Documents/org/tasks/inbox.org"))))))
     ("Ee" "without Emacs"
      ((tags-todo "+Env-Emacs-org"
                  ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                       "~/Documents/org/tasks/inbox.org")))))))))
```
