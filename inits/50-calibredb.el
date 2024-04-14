(el-get-bundle calibredb)

(custom-set-variables
 '(calibredb-root-dir "~/calibre-library"))

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define calibredb-filter-hydra (:separator "-" :exit t :quit-key "q" :title (concat (all-the-icons-material "filter_list") " calibredb filter"))
    ("by"
     (("t" calibredb-filter-by-tag           "Tag")
      ("a" calibredb-filter-by-author-sort   "Author")
      ("f" calibredb-filter-by-book-format   "Format")
      ("d" calibredb-filter-by-last_modified "Updated at")
      ("v" calibredb-virtual-library-list    "Virtual Library")
      ("l" calibredb-library-list            "Library"))

    "Other"
    (("R" calibredb-search-clear-filter "Reset"))))

  (pretty-hydra-define calibredb-sort-hydra (:separator "-" :exit t :quit-key "q" :title (concat (all-the-icons-material "book") " calibredb sort"))
    ("by"
     (("i" calibredb-sort-by-id       "Id")
      ("t" calibredb-sort-by-title    "Title")
      ("f" calibredb-sort-by-format   "Format")
      ("a" calibredb-sort-by-author   "Author")
      ("d" calibredb-sort-by-date     "Created at")
      ("p" calibredb-sort-by-pubdate  "Published at")
      ("T" calibredb-sort-by-tag      "Tag")
      ("s" calibredb-sort-by-size     "Size")
      ("l" calibredb-sort-by-language "Language")
      ;; 関数を定義したりしたら恐らく以下でも検索可能
      ;; author_sort, cover, isbn, last_modified, publisher, rating, series, seried_index, template, uuid)
     )

    "ASC/DESC"
    (("z" calibredb-toggle-order "Toggle"))))

  )
