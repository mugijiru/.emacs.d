(el-get-bundle calibredb)

(custom-set-variables
 '(calibredb-root-dir "~/calibre-library"))

(setopt calibredb-format-nerd-icons t)

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

  (pretty-hydra-define calibredb-metadata-hydra (:separator "-" :exit t :quit-key "q" :title (concat (all-the-icons-material "book") " calibredb metadata"))
    ("Set"
     (("t" calibredb-set-metadata--title       "Title")
      ("g" calibredb-set-metadata--tags        "Tags")
      ("a" calibredb-set-metadata--author_sort "Author sort")
      ("A" calibredb-set-metadata--authors     "Authors")
      ("c" calibredb-set-metadata--comments    "comments"))

     "Fetch"
     (("A" calibredb-fetch-and-set-metadata-by-author-and-title "Author/Title")
      ("I" calibredb-fetch-and-set-metadata-by-isbn             "ISBN")
      ("D" calibredb-fetch-and-set-metadata-by-id               "ID"))

     "Other"
     (("." calibredb-set-metadata-dispatch "Dispatch"))))

  (major-mode-hydra-define calibredb-search-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-material "book") " calibredb-search"))
    ("File/Dir"
     (("a" calibredb-add     "Add")
      ("A" calibredb-add-dir "Add dir")
      ("c" calibredb-clone   "Clone")
      ("r" calibre-remove    "Remove"))

     "Nav"
     (("RET" calibredb-view "Show")
      ("o"   calibredb-open-file-with-default-tool "Open")
      ;; This feature only support macOS
      ;; ("SPC" calibredb-quick-look "Quick")
      )

     "Index"
     (("f" calibredb-filter-hydra/body "Filter")
      ("s" calibredb-sort-hydra/body "Sort")
      ("/" calibredb-search-live-filter "Live"))

     "Virtual Library"
     (("l" calibredb-virtual-library-list     "List")
      ("N" calibredb-virtual-library-next     "Next")
      ("P" calibredb-virtual-library-previous "Prev"))

     "Other"
     (("M" calibredb-metadata-hydra/body "Metadata")))))
