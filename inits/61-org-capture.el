;; org-capture
(defvar org-capture-ical-file (concat org-directory "ical.org"))
(setq org-capture-ical-file (concat org-directory "ical.org"))

(setq my/org-capture-interrupted-file  (concat my/org-tasks-directory "interrupted.org"))
(setq my/org-capture-inbox-file        (concat my/org-tasks-directory "inbox.org"))
(setq my/org-capture-pointers-file     (concat my/org-tasks-directory "pointers.org"))
(setq my/org-capture-impediments-file  (concat org-directory "work/scrum/impediments.org"))
(setq my/org-capture-memo-file         (concat org-directory "memo.org"))
(setq my/org-capture-sql-file          (concat org-directory "work/sql.org"))
(setq my/org-small-topic-file (concat org-directory "small-topic.org"))

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
        ("l" "鑑賞ログ")
        ("lr" "読書メモ" entry
         (id "a0e30a2f-d4ee-426d-9f19-a1bbab2b2563")
         "** %?
%t
*** Reference

*** 感想など
")
        ("lb" "ブログ記事メモ" entry
         (id "e4eed87b-0852-4691-9cd6-4b1596f2b09b")
         "** %?
%t
*** Reference

*** 感想など
")
        ("lm" "映画" entry
         (id "56af8238-c9e8-497c-9695-46849cc8e091")
         "** %?
%t
*** Reference

*** 感想など
")
        ("i" "割り込みタスクにエントリー" entry ;; 参考: http://grugrut.hatenablog.jp/entry/2016/03/13/085417
         (file+headline ,my/org-capture-interrupted-file "Interrupted")
         "** %?\n\t" :clock-in t :clock-resume t)
        ("I" "障害リストにエントリー" entry
         (file+headline ,my/org-capture-impediments-file "Impediments")
         "** TODO %?\n\t")
        ("z" "一言・雑談ネタ" entry
         (file+headline ,my/org-small-topic-file "Topic")
         "** %?\n\t")
        ("s" "SQL にエントリー" entry
         (file+headline ,my/org-capture-sql-file "SQL")
         "** %?\n\t")
        ("b" "Blogネタにエントリー" entry
         (file+headline ,my/org-capture-memo-file "Blogネタ")
         "** %?\n\t")
        ("P" "Protocol" entry
         (file+headline ,my/org-capture-pointers-file "Pointers")
         "** %?\n   #+BEGIN_QUOTE\n   %i\n   #+END_QUOTE\n\n   Source: %u, [[%:link][%:description]]\n")
        ("L" "Protocol Link" entry
         (file+headline ,my/org-capture-pointers-file "Pointers")
         "** %:description\n   %:link\n   %?\n   Captured On: %U")
        ("w" "Web site" entry
         (file+headline ,my/org-capture-pointers-file "Pointers")
         "* %a %^G
%U
%:initial
")
        ("c" "同期カレンダーにエントリー" entry
         (file+headline ,org-capture-ical-file "Schedule")
         "** TODO %?\n\t")))
