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
(custom-set-variables
 '(org-agenda-start-on-weekday 0))
```


## 1日単位をデフォルト表示に設定 {#1日単位をデフォルト表示に設定}

1週間表示よりも「今日って何するんだっけ」みたいな使い方が多いので
1日を表示単位としている。

```emacs-lisp
(custom-set-variables
 '(org-agenda-span 'day))
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
(custom-set-variables
 '(org-agenda-use-time-grid nil))
```


### ブロック間の区切り表示 {#ブロック間の区切り表示}

ブロックとブロックの区切りをハイフン繋ぎの文字列で指定している。

文字列を指定することで固定の長さの区切り文字になるが実は `?-` とか指定して長さが無限に伸びるようにしてもいいかもしれない。と思いつつ、多分 zoom-mode とかでバッファの幅が切り替わる時に邪魔になるから固定でいいか。

```emacs-lisp
(custom-set-variables
 '(org-agenda-block-separator "------------------------------"))
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


### agenda に予定日や締切を表示するための関数 {#agenda-に予定日や締切を表示するための関数}

org-agenda では `org-agenda-prefix-format` に `%s` を指定することで予定日や締切がある場合にそれを簡易表示してくれる機能がある。

のだけどキーワードとして agenda を指定しておく必要があるようで
`todo` などを使う場合にはそれが表示されない。

また、その表示もあまり私の好みではないので、それを良い感じに表示する関数を実装した。

```emacs-lisp
(defun my/org-schedule-or-deadline ()
  (let* ((deadline (org-get-deadline-time (point)))
         (schedule (org-get-scheduled-time (point)))
         (format "%m/%d"))
    (cond
     (deadline
      (concat "[〆: " (format-time-string format deadline) "]"))
     (schedule
      (concat "[予: " (format-time-string format schedule) "]"))
     (t
      ""))))
```

締切が設定されていればそれを、そうではなくスケジュールが設定されていればそれを
`MM/DD` 形式で出力するようにしている。

あと目立つように `[]` で囲ったりどっちの値なのか分かるようにするため 〆 とか 予 とか入れたりしている。


### カスタムビュー {#カスタムビュー}

色々なカスタムビューを定義している。かといって全部使ってるわけではないし、つまり使いこなせているかというと微妙。

そして記述が長くなったので分割して記述していく


#### 変数定義開始 {#変数定義開始}

```emacs-lisp
(custom-set-variables
 '(org-agenda-custom-commands
```


#### 習慣用 agenda {#習慣用-agenda}

習慣用の agenda custom view もいくつか用意している。というわけで h を第一段階の選択に使っている。

```emacs-lisp
   '(("h" . "Habits")
```

<!--list-separator-->

-  平日業務開始時用 agenda

    平日業務開始時にやる作業にタグを設定しているのでそれを抽出するためのカスタムビューの定義。出勤打刻とか直近の TODO の整理だとかをここでやっている。

    まあ実は業務前にやっとくような TODO も混じってるんだけど業務開始時に「これはやったから DONE」みたいにしている。

    ```emacs-lisp
         ("hs" "Weekday Start"
          ((tags "Weekday&Start|Daily"
                 ((org-agenda-prefix-format "  ")
                  (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                             (:name "今日の作業" :scheduled today)
                                             (:discard (:anything t))))))))
    ```

<!--list-separator-->

-  平日業務終了時用 agenda

    こちらは業務終了時に使うカスタムビュー。「退勤打刻」とか「日報を書く」というようなやつが入っている。ちゃんと TODO 管理しないと忘れちゃうからさ、退勤打刻。

    ```emacs-lisp
         ("hf" "Weekday Finish"
          ((tags "Weekday&Finish"
                 ((org-agenda-prefix-format "  ")
                  (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                             (:name "今日の作業" :scheduled today)
                                             (:discard (:anything t))))))))
    ```

<!--list-separator-->

-  週次作業用 agenda

    定例 MTG 用の準備とかのタスクを管理しているカスタムビュー。なのだけど、最近は特に使ってない

    ```emacs-lisp
         ("hw" "Weekly"
          ((tags "Weekly"
                 ((org-agenda-prefix-format "  ")
                  (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                             (:name "今週の作業" :scheduled today)
                                             (:discard (:anything t))))))))
    ```

<!--list-separator-->

-  休日の定例用 agenda

    休日にやるルーチンワークってあるよね。それ用。

    ```emacs-lisp
         ("hh" "Holiday"
          ((tags "Weekend|Holiday|Daily"
                 ((org-agenda-prefix-format "  ")
                  (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                             (:name "今日の作業" :scheduled today)
                                             (:discard (:anything t))))))))
    ```


#### 平日用 agenda {#平日用-agenda}

平日仕事する時に眺めるために用意した agenda なんだけど実際そんなに見てないので見直しが必要かも。

とりあえず Google Calendar に登録されている予定を一番上に表示している。

2番目には、その日の journal ファイルやレビュー対象の PR を載せているファイルのタスクを抽出している。今のところ TODO をネストさせているとそれも全部表示されるのが気に入らないけどそれはまだ直していない。あと良く見ると意味もなく habits.org を参照しているのでそれは後で消しておきたいですね。

3番目には、とりあえずタスクを放り込んでおく projects.org から予定や締切を設定している仕事用のタスクを抽出している。仕事用のタスクというのは agenda-group で指定している。締切とか予定が過ぎているのを上の方に出したり、その日予定のものをだけをまとめていたり、今後1週間の予定に入っているものを並べたりとちょっと工夫している。

4番目には毎日やってるルーチンワークを並べている。出勤打刻とかね。ほら TODO リストにないと結構忘れちゃうので……。

最後に、特に予定や締切を設定していない仕事用のタスクを並べている。いつかやりたいね〜系のものがここに並ぶ感じ。大体ローカルの環境設定をより良い感じにしたいとかが入って来る

```emacs-lisp
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
                   (org-agenda-files `("~/Documents/org/tasks/habits.org"
                                       ,(org-journal--get-entry-path)
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
                 (org-agenda-prefix-format "  %(my/org-schedule-or-deadline) %c: ")
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
                                              (:discard (:anything t))))))))
```


#### 休日用 agenda {#休日用-agenda}

休日にやることは平日とは異なるので別の agenda custom command を用意している。

まず最初に表示するのは journal ファイルに登録されている仕事以外のタスクの抽出。まあここで制御しなくても、仕事のタスクは休日の journal ファイルから projects.org に追い出すんだけどね。見たくないし。

2番目に projects.org から仕事以外の予定タスクをバーッと並べる。まあこれは平日のやつと同じだね。ただ、休日にやりたいことは仕事のやつよりも滅茶苦茶溜まりやすい上にスケジュールぶっちするのでちょっと困ってたりはする。

3番目はルーチンワーク。掃除とかが入って来るやつ。実はこれも数が多い割に気力は足りてないので消化し切れていない。生きるのつらい。

4番目はプライベートタスク。何か誰かと約束しているやつはここに突っ込まれたりするし、とりあえずプライベートでやりたいけど他の分類に仕分けられないやつはここに突っ込む。ここは優先度 C は非表示にしている。優先度が低いのは見えない方が精神衛生に良い。

5番目は Emacs 関係のタスク。ほら休日にやることと言えば Emacs の設定を良い感じにしていくことじゃないですか。大事じゃないですか。これも優先度 C 以下は非表示にしている。けど B とかにしたまま放置しているのが沢山あるのもここだったり

6番目はその他の環境設定用タスク。
Emacs 以外も設定を弄りたいのはいっぱいあるからね。i3wm とか tmux とか。

本当は他にも載せたいんだけど、今あるこれらも全然消化できてないので、それ以外はちょっとこの agenda への掲載を見送っているのが現状。

```emacs-lisp
     ("D" "Holiday"
      ((tags-todo "-Weekday-Daily-Holiday-Weekly-Weekend&LEVEL=3"
                  ((org-agenda-prefix-format " ")
                   (org-agenda-overriding-header "休日の作業")
                   (org-habit-show-habits nil)
                   (org-agenda-prefix-format "  %c: ")
                   (org-agenda-span 'day)
                   (org-agenda-files `(,(org-journal--get-entry-path)))
                   (org-super-agenda-groups '((:name "仕掛かり中" :and (:todo "DOING" :not (:property ("agenda-group" "1. Work"))))
                                              (:name "TODO"       :and (:todo "TODO"  :not (:property ("agenda-group" "1. Work"))))
                                              (:name "待ち"       :and (:todo "WAIT"  :not (:property ("agenda-group" "1. Work"))))
                                              (:discard (:anything t))))))
       (alltodo ""
                ((org-agenda-prefix-format " ")
                 (org-agenda-overriding-header "予定作業")
                 (org-habit-show-habits nil)
                 (org-agenda-prefix-format "  %(my/org-schedule-or-deadline) %c: ")
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
```


#### Projects {#projects}

projects.org に登録している TODO を抽出するための custom views です。

```emacs-lisp
     ("p" . "Projects")
```

<!--list-separator-->

-  Priority A

    優先度 A つまり最優先とされているタスク群。まあ最優先がたくさんあるのが現状なのですが、まあまあ。

    ```emacs-lisp
         ("pA" "Projects Priority A"
          ((tags-todo "LEVEL=2&PRIORITY=\"A\"" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))
    ```

<!--list-separator-->

-  Category

    カテゴリ毎に分類したタスク群

    なのだけどこれ使ってないな。最近カテゴリを別用途にも使ってるから要らないかもしれない

    ```emacs-lisp
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
    ```

<!--list-separator-->

-  Category auto

    自動分類させてみたやつ。特に使ってないな……

    ```emacs-lisp
         ("pC" "Category auto"
          ((tags-todo "LEVEL=2" ((org-agenda-overriding-header "Categories")
                                 (org-agenda-files `(,(concat org-directory "tasks/projects.org")))
                                 (org-super-agenda-groups '((:auto-category t)))))))
    ```

<!--list-separator-->

-  Agenda groups

    agenda-group を設定しているのでそれに基いて分類させているやつ。処理が重いのが難点だけど、時々使ってる。

    ```emacs-lisp
         ("pg" "Agenda groups"
          ((tags-todo "LEVEL=2" ((org-agenda-overriding-header "Categories")
                                 (org-agenda-files `(,(concat org-directory "tasks/projects.org")))
                                 (org-super-agenda-groups '((:auto-group t)))))))
    ```

<!--list-separator-->

-  Projects

    予定を立てている作業を優先的に表示している agenda
    なんだけど daily agenda の方を活用しているのでこっちはあまり使ってない

    ```emacs-lisp
         ("pp" "Projects"
          ((tags-todo "LEVEL=2" ((org-agenda-prefix-format " ")
                                 (org-agenda-overriding-header "今日のタスク")
                                 (org-habit-show-habits nil)
                                 (org-agenda-span 'day)
                                 (org-agenda-todo-keyword-format "-")
                                 (org-agenda-files `("~/Documents/org/tasks/habits.org" ,(org-journal--get-entry-path)))
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
    ```

<!--list-separator-->

-  Projects without Env

    ほぼ上記のやつと同じだけど、なんだかんだで Emacs とかの設定タスクがどんどん増えていくのでそれ以外のタスクを表示するように調整しているやつ。

    これもあまり使ってないかな

    ```emacs-lisp
         ("pP" "Projects without Env"
          ((alltodo "" ((org-agenda-prefix-format " ")
                        (org-agenda-overriding-header "今日のタスク")
                        (org-habit-show-habits nil)
                        (org-agenda-span 'day)
                        (org-agenda-todo-keyword-format "-")
                        (org-agenda-files `("~/Documents/org/tasks/habits.org" ,(org-journal--get-entry-path)))
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
    ```

<!--list-separator-->

-  No major tags

    よく使うタグが付与されてないタスクを抽出するための custom view.
    ろくに管理されてなさそうなタスクを整理する際に使う

    ```emacs-lisp
         ("pN" "No major tags"
          ((tags-todo "-Emacs-org-Env-Hugo-Kibela-Develop-ReviewLister-HouseWork-Private&LEVEL=2" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))
    ```


#### Pointers {#pointers}

溜め込んだ資料を漁るための custom view.
なのだけどいい感じの設定にしてなくてうまく読むこともできないので溜め込まなくなってる悪循環なのでなんとかしたい。

```emacs-lisp
     ("P" "Pointers"
      ((todo "DOING" ((org-agenda-files '("~/Documents/org/tasks/pointers.org"))))
       (todo "TODO"  ((org-agenda-files '("~/Documents/org/tasks/pointers.org"))))))
```


#### Finished {#finished}

完了済のタスクを抽出するやつ。完了したやつがいつまでも残ってると邪魔なのでアーカイブする時に使っている

```emacs-lisp
     ("X" "Finished"
      ((tags "LEVEL=2" ((org-agenda-files `("~/Documents/org/tasks/projects.org"
                                            "~/Documents/org/tasks/inbox.org"
                                            "~/Documents/org/tasks/reviews.org"
                                            ,(org-journal--get-entry-path)
                                            "~/Documents/org/tasks/habits.org"))
                        (org-super-agenda-groups '((:name "Finished" :todo "DONE")
                                                   (:name "Someday" :todo "SOMEDAY")
                                                   (:discard (:anything t))))))))
```


#### 日報 {#日報}

日報出力用。なのだけど今使ってないのよね〜

```emacs-lisp
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
                     (org-agenda-files `("~/Documents/org/tasks/habits.org" ,(org-journal--get-entry-path)))
                     (org-super-agenda-groups (append
                                               (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DONE")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                               '((:discard (:anything t :name "discard")))))))
       (alltodo "" ((org-agenda-prefix-format " ")
                    (org-agenda-overriding-header "仕掛かり中")
                    (org-habit-show-habits nil)
                    (org-agenda-span 'day)
                    (org-agenda-todo-keyword-format "-")
                    (org-agenda-files `("~/Documents/org/tasks/habits.org" ,(org-journal--get-entry-path)))
                    (org-super-agenda-groups (append
                                              (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DOING" "WAIT")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                              '((:discard (:anything t :name "discard")))))))))
```


#### Housework {#housework}

家事用。なんか家事以外も混ぜちゃってるけど、まあ似たようなものなのでヨシ

```emacs-lisp
     ("H" "HouseWork" ((tags "HouseWork")))
```


#### Env {#env}

環境調整用。Emacs の設定とか org-mode の設定とかそれ以外の設定とか物理環境とかそういうものの調整タスクを入れている。

```emacs-lisp
     ("E" . "Env")
```

<!--list-separator-->

-  org

    org-mode 関係の設定用。org-mode はそれだけで色々あるので Emacs の設定とは別に管理したく。

    ```emacs-lisp
         ("EO" "org"
          ((tags-todo "+org"
                      ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                           "~/Documents/org/tasks/inbox.org"))))))
    ```

<!--list-separator-->

-  Emacs without org

    org-mode 以外の Emacs の設定タスク。開発環境の調整とかね。

    ```emacs-lisp
         ("EE" "Emacs without org"
          ((tags-todo "+Emacs-org"
                      ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                           "~/Documents/org/tasks/inbox.org"))))))
    ```

<!--list-separator-->

-  without Emacs

    それ以外の環境調整用。tmux とか shell とかも含むし、作業机とかの物理環境も含む。

    ```emacs-lisp
         ("Ee" "without Emacs"
          ((tags-todo "+Env-Emacs-org"
                      ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                           "~/Documents/org/tasks/inbox.org")))))))))
    ```
