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

  )
