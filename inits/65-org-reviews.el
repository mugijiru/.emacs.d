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
                                    (list cmd "-m" "json" org-or-user repo)
                                    " "))
         (result (shell-command-to-string cmd-with-args)))
    (json-parse-string result)))

(defun my/org-reviews-prs ()
  "レビュー依頼されている PR 全てを取得して flat な emacs lisp の array として返すやつ"
  (let* ((repos-prs (mapcar (lambda (repo)
                              `(,repo ,(my/org-reviews-fetch my/org-reviews-organization repo))) my/org-reviews-repositories))
         (nested-prs (mapcar (lambda (repo-prs)
                               (let* ((repo (car repo-prs))
                                      (prs (cadr repo-prs)))
                                 (mapcar (lambda (pr)
                                           (my/org-reviews-convert-pull-request-to-org-headline pr my/org-reviews-organization repo))
                                         prs)))
                             repos-prs)))
    (cl-reduce (lambda (result prs) (append result prs)) nested-prs)))

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
                                                :tags ,tags
                                                )
                                       paragraph)))
    headline))

(defun my/org-reviews-prs-to-headlines ()
  "レビュー依頼されてい PR 全てを取得して org headline に変換する"
  (let* ((prs (my/org-reviews-prs)))
    (mapcar (lambda (pr)
              (substring-no-properties (org-element-interpret-data pr))) prs)))

(defun my/org-reviews-append-to-file ()
  "レビュー依頼されてい PR 全てを取得してレビューファイルの末尾に書き出す"
  (interactive)
  (let* ((headlines (my/org-reviews-prs-to-headlines))
         (text (string-join headlines)))
    (save-excursion
      (with-current-buffer (find-file-noselect my/org-reviews-file)
        (goto-char (point-max))
        (insert text)))))

;;; org element の操作
;;; Note: まだちゃんと作ってない

(defun XXX-my/org-reviews-change-pr-state-done-or-wait (element)
  "レビュー依頼されていたが今はされてない Pull Request の状態を確認し、
      Open であれば WAIT に Closed であれば DONE に変更する"
  (let ((pull-request-id (org-element-property :PR-ID element)))))

(defun my/org-reviews-extract-text-from-paragraph (paragraph)
  "org-element の paragraph から装飾なしの文字列を抜き出す関数"
  (let* ((begin (org-element-property :begin paragraph))
         (end (org-element-property :end paragraph)))
    (string-trim (substring-no-properties (buffer-substring begin end)))))

(defun my/org-reviews-parse-pull-request-headline (headline)
  "org の headline を parse する関数。Pull Request 用"
  (let* ((level (org-element-property :level headline))
         (title (org-element-property :title headline))
         (splitted-title (split-string title " "))
         (number (string-to-number (substring (car splitted-title) 1)))
         (pr-title (string-join (cdr splitted-title)))
         (content (org-element-contents headline))
         (paragraphs (seq-filter
                      (lambda (element)
                        (eq (org-element-type element) 'paragraph))
                      (cdr (cdar content))))
         (text (mapconcat (lambda (paragraph)
                            (my/org-reviews-extract-text-from-paragraph paragraph))
                          paragraphs
                          ""))
         (tags (org-element-property :tags headline)))

    (if (eq level 1)
        `(:number ,number
                  :title ,pr-title
                  :text ,text
                  :tags ,(mapcar (lambda (tag) (substring-no-properties tag)) tags)
                  :source headline)
      (org-element-adopt-elements headline (my/org-reviews-convert-pull-request-to-org-headline nil)))))

(defun my/org-reviews-pr-headlines ()
  "org のファイルを parse して PR の headline を抜き出す関数"
  (let ((file-path (expand-file-name my/org-reviews-file)))
    (save-excursion
      (with-current-buffer (find-file-noselect file-path)
        (org-element-map (org-element-parse-buffer 'element)
            'headline 'my/org-parse-pull-request-headline)))))

;;; 設定の読み込み

(custom-set-variables
 '(my/org-reviews-organization (plist-get (nth 0 (auth-source-search :host my/org-reviews-token-host)) :organization))
 '(my/org-reviews-repositories
   (split-string (plist-get (nth 0 (auth-source-search :host my/org-reviews-token-host)) :repositories) ",")))
