+++
title = "org-capture"
draft = false
weight = 5
+++

## 概要 {#概要}

org-capture は org-mode 用にさくっとメモを取るための機能。


## org-capture-ical-file <span class="tag"><span class="unused">unused</span></span> {#org-capture-ical-file}

<https://qiita.com/takaxp/items/0b717ad1d0488b74429d> を参考に設定したやつ。

今は別で Google Calendar 連携しているので使ってない……。

```emacs-lisp
;; org-capture
(defvar org-capture-ical-file (concat org-directory "ical.org"))
(setq org-capture-ical-file (concat org-directory "ical.org"))
```


## capture 用ファイルを変数定義 <span class="tag"><span class="improvement">improvement</span></span> {#capture-用ファイルを変数定義}

変数定義しなくてもいい気がしないでもないけどとりあえず変数定義している。バラバラの変数にするよりも alist とか plist とかにする方が適切な気がする

```emacs-lisp
(setq my/org-capture-interrupted-file  (concat my/org-tasks-directory "interrupted.org"))
(setq my/org-capture-inbox-file        (concat my/org-tasks-directory "inbox.org"))
(setq my/org-capture-pointers-file     (concat my/org-tasks-directory "pointers.org"))
(setq my/org-capture-impediments-file  (concat org-directory "work/scrum/impediments.org"))
(setq my/org-capture-memo-file         (concat org-directory "memo.org"))
(setq my/org-capture-sql-file          (concat org-directory "work/sql.org"))
(setq my/org-capture-shopping-file     (concat my/org-tasks-directory "shopping.org"))
(setq my/org-capture-2020-summary-file (concat org-directory "private/2020_summary.org"))
(setq my/org-small-topic-file (concat org-directory "small-topic.org"))
```


## テンプレートの定義 {#テンプレートの定義}

上記の変数を使って capture 用テンプレートを登録している。

| Key | 効果                                 | 備考                                                                                                    |
|-----|------------------------------------|-------------------------------------------------------------------------------------------------------|
| g   | GTD でとりあえず最初に放り込む Inbox に相当するファイルに登録 | Why?, Goal, How? 等の欄を設けることでそのタスクの諸々をハッキリさせようとしている                       |
| m   | とりあえずメモっておきたいやつを放り込む | 最近使ってない。使いにくいのかも                                                                        |
| p   | 資料を放り込むやつ                   | あとで読むリストになってる。読み終わっても、便利そうなのは DONE のまま置いている                        |
| i   | 割込みタスクの登録                   | [org-modeで割り込みにも対応した時間記録をとる方法](https://grugrut.hatenablog.jp/entry/2016/03/13/085417) のやつを流用している。たまに使う。 |
| I   | 開発を進める上での障害をリストアップする用 | 最近使ってない。溜めても振り替えってないので溜める気すらなくなった                                      |
| R   | 2020年の振り返り用                   | もう2020年は過去の話なので不要でしょ                                                                    |
| s   | SQL 用のメモに登録                   | さくっと書いた SQL を後からまた使えないかな〜と思って溜めてみている                                     |
| S   | 買物リストに登録                     | Inbox から refile でもいい気がする                                                                      |
| b   | Blogネタにエントリー                 | 最近使ってない……。ブログ止まってるしな。                                                              |
| P   | Firefox からページの一部を資料として放り込む用 | <https://github.com/sprig/org-capture-extension> 関係。Win では設定できてない                           |
| L   | Firefox からページURLを資料として放り込む用 | <https://github.com/sprig/org-capture-extension> 関係。Win では設定できてない                           |
| c   | スケジュール管理用ファイルに登録     | 使ってない。対象ファイルを変えて使ってみてもいいかも                                                    |

```emacs-lisp
(setq org-capture-templates
      `(("g" "Inbox にエントリー" entry
         (file ,my/org-capture-inbox-file)
         "* TODO %? %^G
%t
** Ready の定義
- Why?, Goal, How? が埋められていること
- How がある程度具体的に書かれていること
** Why?
** Info
** Goal
** How?
** Result
\t")
        ("m" "Memoにエントリー" entry
         (file+headline ,my/org-capture-memo-file "未分類")
         "*** %?\n\t")
        ("p" "Pointersにエントリー" entry
         (file+headline ,my/org-capture-pointers-file "Pointers")
         "** %?\n\t")
        ("i" "割り込みタスクにエントリー" entry ;; 参考: http://grugrut.hatenablog.jp/entry/2016/03/13/085417
         (file+headline ,my/org-capture-interrupted-file "Interrupted")
         "** %?\n\t" :clock-in t :clock-resume t)
        ("I" "障害リストにエントリー" entry
         (file+headline ,my/org-capture-impediments-file "Impediments")
         "** TODO %?\n\t")
        ("R" "2020ふりかえりにエントリー" entry
         (file+headline ,my/org-capture-2020-summary-file "Timeline")
         "** %?\n\t")
        ("z" "一言・雑談ネタ" entry
         (file+headline ,my/org-small-topic-file "Topic")
         "** %?\n\t")
        ("s" "SQL にエントリー" entry
         (file+headline ,my/org-capture-sql-file "SQL")
         "** %?\n\t")
        ("S" "買い物リストエントリー" entry
         (file ,my/org-capture-shopping-file)
         "* TODO %?\n\t")
        ("b" "Blogネタにエントリー" entry
         (file+headline ,my/org-capture-memo-file "Blogネタ")
         "** %?\n\t")
        ("P" "Protocol" entry
         (file+headline ,my/org-capture-pointers-file "Pointers")
         "** %?\n   #+BEGIN_QUOTE\n   %i\n   #+END_QUOTE\n\n   Source: %u, [[%:link][%:description]]\n")
        ("L" "Protocol Link" entry
         (file+headline ,my/org-capture-pointers-file "Pointers")
         "** %:description\n   %:link\n   %?\n   Captured On: %U")
        ("c" "同期カレンダーにエントリー" entry
         (file+headline ,org-capture-ical-file "Schedule")
         "** TODO %?\n\t")))
```
