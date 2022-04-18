;;; init-elfeed.el --- Summary
;;; Commentary:
;;; Code:

(use-package elfeed
  :ensure t
  :config
    (global-set-key (kbd "C-x w") 'elfeed)

    (setq elfeed-feeds
          '(("https://www.emacswiki.org/emacs?action=rss" emacs)
            ("https://static.fsf.org/fsforg/rss/news.xml")
            ("https://static.fsf.org/fsforg/rss/blogs.xml")
            ("http://www.gnu.org/rss/whatsnew.rss")
            ("http://planet.gnu.org/rss20.xml")
            ("https://guix.gnu.org/feeds/blog.atom")
            ("https://www.linuxfoundation.org/feed/")
            ("https://www.debian.org/News/weekly/dwn")
            ("https://archlinux.org/feeds/news/"))))

(provide 'init-elfeed)

;;; init-elfeed.el ends here
