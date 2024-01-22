;;; init-themes.el --- Summary
;;; Commentary:
;;; Code:

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package all-the-icons-ivy

  :ensure t
  :init (all-the-icons-ivy-setup)
  )

(use-package nerd-icons
  :ensure t
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )

;; (use-package all-the-icons-install-fonts
;;   :ensure t)
;; press "M-x" keybinding
;; call the function "all-the-icons-install-fonts" from  prompt.

(use-package projectile
    :ensure t
    :init
        (projectile-mode 1))

;; Let projectile call make
(global-set-key (kbd "<f5>") 'projectile-compile-project)


(use-package dashboard
  :ensure t
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Dashboard!")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-set-footer nil)
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 5)
                          (projects . 5)
                          (registers . 5)))
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))


;;(setq custom-safe-themes t)
;;(add-to-list 'custom-theme-load-path (concat user-emacs-directory "elisp/"))
;;(add-hook 'after-init-hook (lambda () (load-theme 'xresources)))
;;(add-hook 'emacs-startup-hook (lambda () (load-theme 'xresources)))

;; (unless (package-installed-p 'spacemacs-theme)
;;   (package-install 'spacemacs-theme))

;; (use-package spacemacs-theme
;;   :defer t
;;   :init (load-theme 'spacemacs-dark t))

(use-package doom-themes
 :ensure t
 :config
 (load-theme 'doom-one t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


(use-package org-bullets
  :ensure t
  :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(provide 'init-themes)

;;; init-themes.el ends here
