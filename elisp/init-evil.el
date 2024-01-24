;;; init-evil.el --- Summary
;;; Commentary:
;;; Code:

(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))

(require 'undo-tree)


(unless (package-installed-p 'goto-chg)
  (package-install 'goto-chg))

(require 'goto-chg)

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
  (evil-define-key 'normal 'global (kbd "C-n") 'tab-new)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Enable Evil
(require 'evil)
(evil-mode 1)

(provide 'init-evil)
;;; init-evil.el ends here
