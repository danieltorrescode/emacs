;;; init-evil.el --- Summary -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(unless (package-installed-p 'undo-tree) (package-install 'undo-tree))

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
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-C-u-scroll t)
  (setq evil-overriding-maps nil)
  (setq evil-intercept-maps nil)
  :config
  ;; (evil-define-key 'normal 'global (kbd "C-n") 'tab-new)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  ;; --- FIX FOR DASHBOARD ERROR ---
  ;; This removes 'dashboard' from the list of modes evil-collection modifies.
  ;; This prevents the (wrong-type-argument symbolp #f(...)) error.
  ;; (setq evil-collection-mode-list (delq 'dashboard evil-collection-mode-list))
  (setq evil-collection-mode-list (remove 'dashboard evil-collection-mode-list))
  (evil-collection-init)
  ;; (evil-collection-init '(calendar dired calc ediff))
  )

(provide 'init-evil)
;;; init-evil.el ends here
