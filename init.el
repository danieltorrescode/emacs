;;; init.el --- Summary
;;; Commentary:
;;; Code:

(add-to-list 'load-path (concat user-emacs-directory "/elisp"))

(require 'settings)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))
(require 'init-evil)
(require 'init-completion)
(require 'init-themes)
(require 'init-development)

;; (unless (package-installed-p 'exwm)
;;   (package-install 'exwm))

;; (require 'exwm)
;; (require 'exwm-config)
;; (require 'init-exwm)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lsp-pyright dap-mode lsp-ivy lsp-ui lsp-mode flycheck magit org-bullets doom-modeline doom-themes dashboard projectile nerd-icons all-the-icons-ivy all-the-icons-dired all-the-icons counsel ivy company-box company which-key evil-collection evil goto-chg undo-tree)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
