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
            ("https://guix.gnu.org/feeds/blog.atom")
            ("https://nitter.net/learnemacs/rss")
            ("https://sachachua.com/blog/feed/")
            ("https://cestlaz.github.io/rss.xml")
            ("https://protesilaos.com/news.xml")
            ("http://pragmaticemacs.com/feed/")
            ("http://www.howardism.org/index.xml")
            ("https://planet.emacslife.com/atom.xml")
            ("https://planet.debian.org/rss20.xml")
            ("file:///tmp/mozilla_daniel0/news")
            ("https://bits.debian.org/feeds/feed.rss")
            ("https://www.muylinux.com/feed/")
            ("https://itsfoss.com/feed/")
            ("https://opensource.com/feed")
            ("https://distrowatch.com/news/dw.xml")
            ("https://www.postgresql.org/news.rss")
            ("https://www.postgresql.org/news/pgsql.rss")
            ("https://www.docker.com/blog/feed/")
            ("https://planet.lisp.org/rss20.xml")
            ("https://blog.heroku.com/feed")
            ("https://stackoverflow.blog/feed/")
            ("https://www.sciencenews.org/feed")
            ("http://feeds2.feedburner.com/Ebookss")
            ("https://lukesmith.xyz/rss.xml")
            ("https://lukesmith.xyz/youtube.xml")
            ("https://www.distrotube.com/videos/index.xml")
            ("https://notrelated.xyz/rss")
            ("https://blog.mozilla.org/feed/")
            ("https://spreadprivacy.com/rss/")
            ("https://protonmail.com/blog/feed/" protonmail))))

(provide 'init-elfeed)

;;; init-elfeed.el ends here
