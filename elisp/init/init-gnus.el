;;; init-gnus.el --- Summary
;;; Commentary:
;;; Code:

(use-package gnus
  :config
  ;; accounts
    (setq gnus-select-method '(nntp "news.gnus.org"))
    (add-to-list 'gnus-secondary-select-methods '(nntp "news.gwene.org"))
    (add-to-list 'gnus-secondary-select-methods '(nnml "")))

;; (use-package gnus
;;   :config
;;   ;; accounts
;;   (setq gnus-select-method '(nnnil ""))
;;   (setq gnus-secondary-select-methods
;;         '((nntp "news.gwene.org")
;;           (nnmaildir "prv" (directory "~/.mail/prv"))
;;           (nnmaildir "inf" (directory "~/.mail/inf"))
;;           (nnmaildir "pub" (directory "~/.mail/pub"))))

;;   (setq nnir-method-default-engines
;;         '((nnmaildir . notmuch)))

;;   (setq gnus-parameters
;;         '((".*"                         ; fallback option
;;            (posting-style
;;             (gcc "nnmaildir+inf:Sent")
;;             (From
;;              (format "%s <%s>" user-full-name
;;                      (prot-common-auth-get-field "inf" :user)))))
;;           ("prv"
;;            (posting-style
;;             (gcc "nnmaildir+prv:Sent")
;;             (From
;;              (format "%s <%s>" user-full-name
;;                      (prot-common-auth-get-field "prv" :user)))))
;;           ("pub"
;;            (posting-style               ; Uses default name+mail
;;             (gcc "nnmaildir+pub:Sent")))))

;;   (setq gnus-gcc-mark-as-read t)
;;   (setq gnus-agent t)
;;   (setq gnus-novice-user nil)
;;   ;; checking sources
;;   (setq gnus-check-new-newsgroups 'ask-server)
;;   (setq gnus-read-active-file 'some)
;;   ;; dribble
;;   (setq gnus-use-dribble-file t)
;;   (setq gnus-always-read-dribble-file t)
;;   :bind ("C-c m" . gnus))

;; (use-package nnmail
;;   :config
;;   (setq nnmail-expiry-wait 30))

(provide 'init-gnus)

;;; init-gnus.el ends here
