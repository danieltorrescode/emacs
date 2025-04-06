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


;; (use-package projectile
;;     :ensure t
;;     :init
;;         (projectile-mode +1))

;; Recommended keymap prefix on Windows/Linux
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; Let projectile call make
;; (global-set-key (kbd "<f5>") 'projectile-compile-project)


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


(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


(use-package org-bullets
  :ensure t
  :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(provide 'init-themes)

;;; init-themes.el ends here
