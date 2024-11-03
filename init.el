;;; init.el --- Summary
;;; Commentary:
;;; Code:

(add-to-list 'load-path (concat user-emacs-directory "/elisp"))

(require 'settings)

(require 'init-evil)
(require 'init-themes)
(require 'init-completion)
(require 'init-development)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(org-agenda-files '("~/Documents/emacs.org"))
 '(package-selected-packages
   '(elfeed-tube highlight-indent-guides which-key undo-tree tsc tide rjsx-mode projectile prettier-js org-bullets magit lsp-ui lsp-pyright lsp-ivy evil-collection doom-themes doom-modeline dashboard dap-mode counsel company-box all-the-icons-ivy all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
