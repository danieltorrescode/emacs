;;; init-rss-reader.el --- Summary
;;; Commentary:
;;; Code:

(use-package elfeed
  :ensure t
  :config
  (setq elfeed-search-feed-face ":foreground #ffffff :weight bold"))

(use-package elfeed-goodies
  :ensure t
  :init
  (elfeed-goodies/setup)
  :config
  (setq elfeed-goodies/entry-pane-size 0.5))

(use-package elfeed-tube
  :ensure t ;; or :straight t
  :after elfeed
  :demand t
  :config
  (setq elfeed-tube-auto-save-p nil) ; default value
  (setq elfeed-tube-auto-fetch-p t)  ; default value
  (elfeed-tube-setup)

  :bind (:map elfeed-show-mode-map
              ("F" . elfeed-tube-fetch)
              ([remap save-buffer] . elfeed-tube-save)
              :map elfeed-search-mode-map
              ("F" . elfeed-tube-fetch)
              ([remap save-buffer] . elfeed-tube-save)))


(global-set-key (kbd "C-x w") 'elfeed)
(global-set-key (kbd "C-x M-w") 'elfeed-update)
;; Load the external Elfeed feeds list
(load-file "~/Documents/feeds.el")

;; (setq-default elfeed-search-filter "@1-week-ago +unread ")

(evil-define-key 'normal elfeed-show-mode-map
  (kbd "J") 'elfeed-goodies/split-show-next
  (kbd "K") 'elfeed-goodies/split-show-prev)
(evil-define-key 'normal elfeed-search-mode-map
  (kbd "J") 'elfeed-goodies/split-show-next
  (kbd "K") 'elfeed-goodies/split-show-prev)

(provide 'init-rss-reader)

;;; init-rss-reader.el ends here
