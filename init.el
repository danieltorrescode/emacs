;;; init.el --- Summary
;;; Commentary:
;;; Code:

(require 'package)
(setq package-enable-at-startup nil)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)
;; first type the above lines and run the init.el script
;; then run M-x package-refresh-contents
;; now can install use-package

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
(add-to-list 'load-path (concat user-emacs-directory "elisp" "/packages"))

(require 'emacs-config)

(require 'init-use-package)

(require 'init-swiper)
(require 'init-ivy)
(require 'init-counsel)
(require 'init-auto-complete)

(require 'init-org-bullets)
(require 'init-which-key)
(require 'init-undo-tree)
(require 'init-goto-chg)

(require 'init-evil-mode)

(require 'init-icons)
(require 'init-projectile)
(require 'init-dashboard)
(require 'init-themes)

(require 'init-lsp-mode)
(require 'init-flycheck)
(require 'init-magit)

(require 'init-dired-preview)
(require 'init-developer-mode)

;; (require 'init-gnus)
;; (require 'init-elfeed)


;; (unless (package-installed-p 'exwm)
;;   (package-install 'exwm))

;; (require 'exwm)
;; (require 'exwm-config)
;; (require 'init-exwm)
;; (require 'init-lemonbar)
;; (require 'init-wallpaper)

(provide 'init)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lsp-pyright prettier-js prettier-emacs dired-preview evil-collection evil goto-chg dashboard projectile org-bullets all-the-icons doom-modeline doom-themes use-package cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'counsel-compile-env 'disabled t)
