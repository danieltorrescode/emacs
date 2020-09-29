(use-package dashboard
  :ensure t
  :config
  :init
  (dashboard-setup-startup-hook))


;;In addition to the above, configure initial-buffer-choice
;; to show Dashboard in frames created with emacsclient -c as follows
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

;; Set the title
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")

;; Set the banner
;; (setq dashboard-startup-banner "~/.config/emacs_logo.png")
(setq dashboard-startup-banner 'logo)
;; (setq dashboard-startup-banner 'official)
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.png" which displays whatever image you would prefer

;; Content is not centered by default. To center, set
;; (setq dashboard-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)

(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))



;; To add icons to the widget headings and their items:
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

;; To show info about the packages loaded and the init time:
;; (setq dashboard-set-init-info t)

;; Also, the message can be customized like this:
;; (setq dashboard-init-info "This is an init message!")

;; A randomly selected footnote will be displayed. To disable it:
(setq dashboard-set-footer nil)

(provide 'init-dashboard)
