;; themes.el

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

(provide 'init-themes)

