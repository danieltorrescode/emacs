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
(require 'undo-tree)
(require 'goto-chg)

;; (unless (package-installed-p 'exwm)
;;   (package-install 'exwm))

;; (require 'exwm)
;; (require 'exwm-config)
;; (require 'exwm-custom-config)
;; ;(exwm-config-default)
;; (require 'init-lemonbar)
;; (require 'init-wallpaper)

(require 'init-themes)
(require 'init-icons)
(require 'init-org-bullets)
(require 'init-projectile)
(require 'init-dashboard)

(require 'init-avy)
(require 'init-swiper)
(require 'init-ivy)
(require 'init-counsel)
(require 'init-yasnippet)
(require 'init-auto-complete)
(require 'init-mark-multiple)
(require 'init-which-key)

(require 'init-magit)
(require 'init-flycheck)
(require 'init-gnus)
(require 'init-elfeed)
;;(require 'init-javascript)



(provide 'init)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(elfeed flycheck magit which-key mark-multiple auto-complete yasnippet-snippets yasnippet counsel swiper avy dashboard projectile org-bullets all-the-icons doom-modeline doom-themes use-package cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
