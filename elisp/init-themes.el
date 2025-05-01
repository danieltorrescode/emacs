;;; init-themes.el --- Summary -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; (use-package all-the-icons-install-fonts
;;   :ensure t)
;; press "M-x" keybinding
;; call the function "all-the-icons-install-fonts" from  prompt.

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package nerd-icons
  :ensure t
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


(use-package org-bullets
  :ensure t
  :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(use-package dashboard
  :ensure t
  :init
  :config
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Dashboard!")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  ;; (setq dashboard-set-footer nil)
  (setq dashboard-footer-messages '(""))
  (setq dashboard-projects-backend 'project-el)
  ;; (setq dashboard-projects-switch-function 'projectile-persp-switch-project)
  (setq dashboard-items '((recents . 10)
                          (agenda . 10)
                          (bookmarks . 10)
                          (projects . 10)))
  (dashboard-setup-startup-hook))

(global-set-key (kbd "M-d") 'dashboard-open)

(provide 'init-themes)

;;; init-themes.el ends here
