;;; init.el --- Summary
;;; Commentary:
;;; Code:

(add-to-list 'load-path (concat user-emacs-directory "/elisp"))

(require 'settings)

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
   '(highlight-indent-guides which-key undo-tree tsc tide rjsx-mode projectile prettier-js org-bullets magit lsp-ui lsp-pyright lsp-ivy evil-collection doom-themes doom-modeline dashboard dap-mode counsel company-box all-the-icons-ivy all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
