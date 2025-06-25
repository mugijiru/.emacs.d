(require 'mu4e)

(defun offlineimap-get-username (host)
  (plist-get (nth 0 (auth-source-search :host host)) :user))

(defun offlineimap-get-password (host)
  (funcall (plist-get (nth 0 (auth-source-search :host host :max 1)) :secret)))

(setopt mu4e-root-maildir "~/Maildir")
(setopt mu4e-get-mail-command "offlineimap")
(setopt mu4e-update-interval 600) ; 10 minutes
(setopt mu4e-notification-support t)

(setopt mu4e-contexts
        (list
         (make-mu4e-context
          :name "prov"
          :enter-func(lambda () (mu4e-message "Switch to the Provider context"))
          :leave-func (lambda () (mu4e-message "Leaving the Provider context"))
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/prov" (mu4e-message-field msg :maildir))))
          :vars `((user-mail-address . ,(offlineimap-get-username "offlineimap-prov"))
                  (user-full-name . ,(plist-get (nth 0 (auth-source-search :host "offlineimap-prov")) :fullname))
                  (mu4e-sent-folder . "/prov/Sent")
                  (mu4e-drafts-folder . "/prov/Drafts")
                  (mu4e-trash-folder . "/prov/Trash")
                  (mu4e-compose-signature . ,(concat (plist-get (nth 0 (auth-source-search :host "offlineimap-prov")) :fullname) "\n"))
                  (mu4e-maildir-shortcuts . (("/prov/INBOX" . ?i)
                                             ("/prov/Sent" . ?s)
                                             ("/prov/Drafts" . ?d)
                                             ("/prov/Trash" . ?t)))))
         (make-mu4e-context
          :name "bj"
          :enter-func(lambda () (mu4e-message "Switch to the Bj context"))
          :leave-func (lambda () (mu4e-message "Leaving the Bj context"))
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/bj" (mu4e-message-field msg :maildir))))
          :vars `((user-mail-address . ,(offlineimap-get-username "offlineimap-bj"))
                  (user-full-name . ,(plist-get (nth 0 (auth-source-search :host "offlineimap-bj")) :fullname))
                  (mu4e-sent-folder . "/bj/[Gmail].送信済みメール")
                  (mu4e-drafts-folder . "/bj/[Gmail].下書き")
                  (mu4e-trash-folder . "/bj/[Gmail].ゴミ箱")
                  (mu4e-refile-folder . "/bj/[Gmail].すべてのメール")
                  (mu4e-compose-signature . ,(concat (plist-get (nth 0 (auth-source-search :host "offlineimap-bj")) :fullname) "\n"))
                  (mu4e-maildir-shortcuts . ((:maildir "/bj/INBOX"                  :key ?i :name "INBOX")
                                             (:maildir "/bj/[Gmail].送信済みメール" :key ?s :name "送信済み")
                                             (:maildir "/bj/[Gmail].すべてのメール" :key ?a :name "すべてのメール")
                                             (:maildir "/bj/[Gmail].下書き"         :key ?d :name "下書き")
                                             (:maildir "/bj/[Gmail].ゴミ箱"         :key ?t :name "ゴミ箱")
                                             ))))
         (make-mu4e-context
          :name "main"
          :enter-func(lambda () (mu4e-message "Switch to the Main context"))
          :leave-func (lambda () (mu4e-message "Leaving the Main context"))
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/main" (mu4e-message-field msg :maildir))))
          :vars `((user-mail-address . ,(offlineimap-get-username "offlineimap-main"))
                  (user-full-name . ,(plist-get (nth 0 (auth-source-search :host "offlineimap-main")) :fullname))
                  (mu4e-sent-folder . "/main/[Gmail].送信済みメール")
                  (mu4e-drafts-folder . "/main/[Gmail].下書き")
                  (mu4e-trash-folder . "/main/[Gmail].ゴミ箱")
                  (mu4e-refile-folder . "/main/[Gmail].すべてのメール")
                  (mu4e-compose-signature . ,(concat (plist-get (nth 0 (auth-source-search :host "offlineimap-main")) :fullname) "\n"))
                  (mu4e-maildir-shortcuts . ((:maildir "/main/INBOX"                  :key ?i :name "INBOX")
                                             (:maildir "/main/[Gmail].送信済みメール" :key ?s :name "送信済み")
                                             (:maildir "/main/[Gmail].すべてのメール" :key ?a :name "すべてのメール")
                                             (:maildir "/main/[Gmail].下書き"         :key ?d :name "下書き")
                                             (:maildir "/main/[Gmail].ゴミ箱"         :key ?t :name "ゴミ箱")
                                             ))))
         (make-mu4e-context
          :name "dev"
          :enter-func(lambda () (mu4e-message "Switch to the Dev context"))
          :leave-func (lambda () (mu4e-message "Leaving the Dev context"))
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/dev" (mu4e-message-field msg :maildir))))
          :vars `((user-mail-address . ,(offlineimap-get-username "offlineimap-dev"))
                  (user-full-name . ,(plist-get (nth 0 (auth-source-search :host "offlineimap-dev")) :fullname))
                  (mu4e-sent-folder . "/dev/[Gmail].送信済みメール")
                  (mu4e-drafts-folder . "/dev/[Gmail].下書き")
                  (mu4e-trash-folder . "/dev/[Gmail].ゴミ箱")
                  (mu4e-refile-folder . "/dev/[Gmail].すべてのメール")
                  (mu4e-compose-signature . ,(concat (plist-get (nth 0 (auth-source-search :host "offlineimap-dev")) :fullname) "\n"))
                  (mu4e-maildir-shortcuts . ((:maildir "/dev/INBOX"                  :key ?i :name "INBOX")
                                             (:maildir "/dev/[Gmail].送信済みメール" :key ?s :name "送信済み")
                                             (:maildir "/dev/[Gmail].すべてのメール" :key ?a :name "すべてのメール")
                                             (:maildir "/dev/[Gmail].下書き"         :key ?d :name "下書き")
                                             (:maildir "/dev/[Gmail].ゴミ箱"         :key ?t :name "ゴミ箱")
                                             ))))
         (make-mu4e-context
          :name "nue"
          :enter-func(lambda () (mu4e-message "Switch to the Nue context"))
          :leave-func (lambda () (mu4e-message "Leaving the Nue context"))
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/nue" (mu4e-message-field msg :maildir))))
          :vars `((user-mail-address . ,(offlineimap-get-username "offlineimap-nue"))
                  (user-full-name . ,(plist-get (nth 0 (auth-source-search :host "offlineimap-nue")) :fullname))
                  (mu4e-sent-folder . "/nue/[Gmail].送信済みメール")
                  (mu4e-drafts-folder . "/nue/[Gmail].下書き")
                  (mu4e-trash-folder . "/nue/[Gmail].ゴミ箱")
                  (mu4e-refile-folder . "/nue/[Gmail].すべてのメール")
                  (mu4e-compose-signature . ,(concat (plist-get (nth 0 (auth-source-search :host "offlineimap-nue")) :fullname) "\n"))
                  (mu4e-maildir-shortcuts . ((:maildir "/nue/INBOX"                  :key ?i :name "INBOX")
                                             (:maildir "/nue/[Gmail].送信済みメール" :key ?s :name "送信済み")
                                             (:maildir "/nue/[Gmail].すべてのメール" :key ?a :name "すべてのメール")
                                             (:maildir "/nue/[Gmail].下書き"         :key ?d :name "下書き")
                                             (:maildir "/nue/[Gmail].ゴミ箱"         :key ?t :name "ゴミ箱")
                                             ))))))
