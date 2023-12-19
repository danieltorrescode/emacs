;;; init-evil-mode.el --- Summary
;;; Commentary:
;;; Code:

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))


(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Enable Evil
(require 'evil)
(evil-mode 1)

(provide 'init-evil-mode)
;;; init-evil-mode.el ends here
