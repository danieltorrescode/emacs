;;; init-dired-preview.el --- Summary
;;; Commentary:
;;; Code:


(unless (package-installed-p 'dired-preview)
  (package-install 'dired-preview))

(require 'dired-preview)

;; Default values for demo purposes
(setq dired-preview-delay 0.7)
(setq dired-preview-max-size (expt 2 20))

(setq dired-preview-ignored-extensions-regexp
      (concat "\\."
              "\\(mkv\\|webm\\|mp4\\|mp3\\|ogg\\|m4a"
              "\\|gz\\|zst\\|tar\\|xz\\|rar\\|zip"
              "\\|iso\\|epub\\|pdf\\)"))

;; Enable `dired-preview-mode' in a given Dired buffer or do it
(dired-preview-global-mode 1)

(provide 'init-dired-preview)

;;; init-dired-preview.el ends here
