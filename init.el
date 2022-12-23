;;; init.el --- Summary
;;; Commentary:
;;; Code:

(require 'package)
(setq package-enable-at-startup nil)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)
;; first type the above lines and run the init.el script
;; then run M-x package-refresh-contents
;; now can install use-package

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
(add-to-list 'load-path (concat user-emacs-directory "elisp" "/init"))

(require 'emacs-config)
(require 'use-package)

;; (unless (package-installed-p 'exwm)
;;   (package-install 'exwm))

;; (require 'exwm)
;; (require 'exwm-config)
;; (require 'init-exwm)
;; (require 'init-lemonbar)
;; (require 'init-wallpaper)

(require 'init-themes)
(require 'init-icons)
(require 'init-org-bullets)
(require 'init-projectile)
(require 'init-dashboard)

(require 'init-swiper)
(require 'init-ivy)
(require 'init-counsel)
(require 'init-auto-complete)
(require 'init-which-key)
(require 'init-undo-tree)

;; (require 'init-gnus)
;; (require 'init-elfeed)


(provide 'init)

;;; init.el ends here
