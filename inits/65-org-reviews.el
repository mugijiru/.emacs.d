(defgroup my/org-reviews nil
  "オレオレレビュー一覧同期ツール用"
  :prefix "my/org-reviews-"
  :group 'org)

(defcustom my/org-reviews-organization nil
  "organization name"
  :group 'my/org-reviews)
(defcustom my/org-reviews-repositories '()
  "list of repositories"
  :group 'my/org-reviews)
(defcustom my/org-reviews-file "~/Documents/org/tasks/reviews.org"
  "save file name"
  :group 'my/org-reviews)

(defconst my/org-reviews-token-name "MY_GITHUB_TOKEN")
(defconst my/org-reviews-token-host "reviews")
(defconst my/org-reviews-exec-path "~/bin/review-requested-prs")

;;; リポジトリからの情報取得

(defun my/org-reviews-fetch (org-or-user repo)
  "指定したリポジトリのレビュー依頼されている PR を取得して emacs lisp の array として返すやつ"
  (unless (getenv my/org-reviews-token-name)
    (setenv my/org-reviews-token-name
            (funcall (plist-get (nth 0 (auth-source-search :host my/org-reviews-token-host)) :secret))))

  (let* ((cmd (expand-file-name my/org-reviews-exec-path))
         (cmd-with-args (mapconcat #'shell-quote-argument
                                   (list cmd "-m" "json" "--ignore-title" "Deploy" org-or-user repo)
                                   " "))
         (result (shell-command-to-string cmd-with-args)))
    (sleep-for 1)
    (condition-case err
        (json-parse-string result)
      (error
       (message "error: %s\ncmd: %s\nresult: %s" err cmd-with-args result)
       nil))))

(defun my/org-reviews-prs ()
  "レビュー依頼されている PR 全てを取得して flat な emacs lisp の array として返すやつ"
  (let* ((repos-prs (mapcar (lambda (repo)
                              `(,repo ,(my/org-reviews-fetch my/org-reviews-organization repo))) my/org-reviews-repositories))
         (nested-prs (mapcar (lambda (repo-prs)
                               (let* ((repo (car repo-prs))
                                      (prs (cadr repo-prs)))
                                 (mapcar (lambda (pr)
                                           (my/org-reviews-convert-pull-request-to-list pr my/org-reviews-organization repo))
                                         prs)))
                             repos-prs)))
    (cl-reduce (lambda (result prs) (append result prs)) nested-prs)))

(defun my/org-reviews-convert-pull-request-to-list (pr org repo)
  "PR から list に変換"
  (let* ((number (gethash "number" pr))
         (title (gethash "title" pr))
         (text (concat "https://github.com/" org "/" repo "/pull/" (number-to-string number)))
         (tags (mapcar (lambda (tag) (string-replace " " "" tag)) (append (gethash "tags" pr) '()))))
    `(:number ,number
              :title ,title
              :todo-keyword "TODO"
              :text ,text
              :tags ,(mapcar (lambda (tag) (substring-no-properties tag)) tags))))

(defun my/org-reviews-merge-prs (saved-prs fetched-prs)
  (let* ((merged-prs (mapcar (lambda (saved-pr)
                               (let ((same-pr (seq-find (lambda (fetched-pr)
                                                          (let* ((saved-number (plist-get saved-pr :number))
                                                                 (fetched-number (plist-get fetched-pr :number)))
                                                            (eq saved-number fetched-number)))
                                                        fetched-prs)))
                                 (if same-pr
                                     (my/org-reviews-merge saved-pr same-pr)
                                   (my/org-reviews-done saved-pr))))
                             saved-prs))
         (saved-numbers (mapcar (lambda (saved-pr)
                                  (plist-get saved-pr :number))
                                saved-prs))
         (new-prs (seq-filter (lambda (fetched-pr)
                                (let ((fetched-pr-number (plist-get fetched-pr :number)))
                                  (not (seq-contains-p saved-numbers fetched-pr-number))))
                              fetched-prs)))
    (append merged-prs new-prs)))

(defun my/org-reviews-done (saved)
  (plist-put saved :todo-keyword "DONE")
  saved)

(defun my/org-reviews-merge (saved fetched)
  "同じ number の PR をマージ"
  (if (eq (plist-get saved :number) (plist-get fetched :number))
      (let* ((number (plist-get saved :number))
             (title (plist-get fetched :title))
             (scheduled (plist-get saved :scheduled))
             (deadline (plist-get saved :deadline))
             (closed (plist-get saved :closed))
             (todo-keyword (or (plist-get saved :todo-keyword) (plist-get fetched :todo-keyword)))
             (text (or (plist-get saved :text) (plist-get fetched :text)))
             (tags (or (plist-get saved :tags) (plist-get fetched :tags)))
             (source (plist-get saved :source)))
        `(:number ,number
                  :title ,title
                  :todo-keyword ,todo-keyword
                  :text ,text
                  :scheduled ,scheduled
                  :deadline ,deadline
                  :closed ,closed
                  :tags ,(mapcar (lambda (tag) (substring-no-properties tag)) tags)
                  :source ,source))))

(defun my/org-reviews-list-item-to-org-headline (list-item)
  (let* ((number (plist-get list-item :number))
         (todo-keyword (plist-get list-item :todo-keyword))
         (title (plist-get list-item :title))
         (scheduled (plist-get list-item :scheduled))
         (deadline (plist-get list-item :deadline))
         (closed (plist-get list-item :closed))
         (tags (plist-get list-item :tags))
         (text (plist-get list-item :text))
         (source (plist-get list-item :source))
         (drawers-str (if (eq (org-element-type source) 'headline)
                          (org-element-map
                              source
                              'drawer
                            (lambda (drawer)
                              (let* ((begin (org-element-property :begin drawer))
                                     (end (org-element-property :end drawer)))
                                (save-excursion
                                  (with-current-buffer (find-file-noselect my/org-reviews-file)
                                    (string-trim (substring-no-properties (buffer-substring begin end))))))))))
         (content (if drawers-str
                      (concat "   " (string-join drawers-str) "\n" text)
                    (concat "   " text)))
         (planning (if (or scheduled deadline closed)
                       (org-element-create 'planning
                                           `(:scheduled ,scheduled :deadline ,deadline :closed ,closed))))
         (paragraph (org-element-create 'paragraph '(:post-blank 2) content))
         (children (remove nil `(,planning ,paragraph))))
    (apply #'org-element-create 'headline
           `(:title ,(concat "#" (number-to-string number) " " title)
                    :level 2
                    :todo-keyword ,todo-keyword
                    :tags ,tags)
           children)))

(defun my/org-reviews-convert-pull-request-to-org-headline (pr org repo)
  "PR から org の headline に変換"
  (let* ((number (gethash "number" pr))
         (number-str (number-to-string number))
         (title (gethash "title" pr))
         (tags (mapcar (lambda (tag) (string-replace " " "" tag)) (append (gethash "tags" pr) '())))
         (paragraph (org-element-create 'paragraph '(:post-blank 2) (concat "https://github.com/" org "/" repo "/pull/" number-str)))
         (headline (org-element-create 'headline
                                       `(:title ,(concat "#" number-str " " title)
                                                :level 2
                                                :todo-keyword "TODO"
                                                :tags ,tags)
                                       paragraph)))
    headline))

(defun my/org-reviews-execute ()
  (interactive)
  (find-file-other-window my/org-reviews-file)
  (let* ((saved-prs (my/org-reviews-pr-headlines))
         (fetched-prs (my/org-reviews-prs))
         (merged-prs (my/org-reviews-merge-prs saved-prs fetched-prs))
         (headlines (mapcar #'my/org-reviews-list-item-to-org-headline merged-prs))
         (root (apply #'org-element-create
                      'headline
                      `(:title "reviews" :level 1)
                      (org-element-create 'property-drawer
                                          `(:begin 0
                                                   :end 0
                                                   :contents-begin 0
                                                   :contents-end 0
                                                   :post-blank 0
                                                   :post-affiliated 0)
                                          (org-element-create 'node-property
                                                              (list :key "agenda-group"
                                                                    :value "01_レビュー"))
                                          (org-element-create 'node-property
                                                              (list :key "CATEGORY"
                                                                    :value "レビュー")))
                      headlines))
         (text (substring-no-properties (org-element-interpret-data root))))
    (my/org-reviews-append-to-file-2 text)
    nil))

(defun my/org-reviews-prs-to-headlines ()
  "レビュー依頼されてい PR 全てを取得して org headline に変換する"
  (let* ((prs (my/org-reviews-prs)))
    (mapcar (lambda (pr)
              (substring-no-properties (org-element-interpret-data pr))) prs)))

(defun my/org-reviews-append-to-file-2 (text)
  "レビュー依頼されている PR 全てを取得してレビューファイルの末尾に書き出す"
  (save-excursion
    (with-current-buffer (find-file-noselect my/org-reviews-file)
      (erase-buffer)
      (goto-char (point-max))
      (insert "#+TODO: TODO(t) DOING(d) WAIT(w) | ACCEPTED(a) | DONE(o)\n")
      (insert text))))

;;; org element の操作
;;; Note: まだちゃんと作ってない

(defun my/org-reviews-extract-text-from-paragraph (paragraph)
  "org-element の paragraph から装飾なしの文字列を抜き出す関数"
  (let* ((begin (org-element-property :begin paragraph))
         (end (org-element-property :end paragraph)))
    (string-trim (substring-no-properties (buffer-substring begin end)))))

(defun my/org-reviews-parse-pull-request-headline (headline)
  "org の headline を parse する関数。Pull Request 用"
  (let* ((level (org-element-property :level headline))
         (todo-keyword (org-element-property :todo-keyword headline))
         (title (org-element-property :title headline))
         (splitted-title (split-string title " "))
         (number (string-to-number (substring (car splitted-title) 1)))
         (pr-title (string-join (cdr splitted-title) " "))
         (scheduled (org-element-property :scheduled headline))
         (deadline (org-element-property :deadline headline))
         (closed (org-element-property :closed headline))
         (content (org-element-contents headline))
         (children (cdr (cdar content)))
         (paragraphs (seq-filter
                      (lambda (element)
                        (eq (org-element-type element) 'paragraph))
                      children))
         (text (mapconcat (lambda (paragraph)
                            (my/org-reviews-extract-text-from-paragraph paragraph))
                          paragraphs
                          ""))
         (tags (org-element-property :tags headline)))
    (if (eq level 2)
        `(:number ,number
                  :todo-keyword ,todo-keyword
                  :title ,pr-title
                  :text ,text
                  :scheduled ,scheduled
                  :deadline ,deadline
                  :closed ,closed
                  :tags ,(mapcar (lambda (tag) (substring-no-properties tag)) tags)
                  :source ,headline))))

(defun my/org-reviews-pr-headlines ()
  "org のファイルを parse して PR の headline を抜き出す関数"
  (let ((file-path (expand-file-name my/org-reviews-file)))
    (save-excursion
      (with-current-buffer (find-file-noselect file-path)
        (let* ((org-data (org-element-parse-buffer 'element))
               (org-first (car org-data)))
          (org-element-map org-data
              'headline 'my/org-reviews-parse-pull-request-headline))))))

;;; 設定の読み込み

(custom-set-variables
 '(my/org-reviews-organization (plist-get (nth 0 (auth-source-search :host my/org-reviews-token-host)) :organization))
 '(my/org-reviews-repositories
   (split-string (plist-get (nth 0 (auth-source-search :host my/org-reviews-token-host)) :repositories) ",")))
