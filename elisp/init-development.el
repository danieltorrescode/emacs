;;; init-development.el --- Summary -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; (setq c-default-style "linux"
;;       c-basic-offset 4)

(setq major-mode-remap-alist
      '((c-mode . c-ts-mode)))

(use-package c-ts-mode
  :hook ((c-ts-mode . eglot-ensure)
         (c-ts-mode . company-mode))
  :mode (("\\.c\\'" . c-ts-mode)))


(use-package yaml-ts-mode
  :hook ((yaml-ts-mode . company-mode))
  :mode (("\\.yml\\'" . yaml-ts-mode)))

(use-package python-ts-mode
  :hook ((python-ts-mode . eglot-ensure)
         (python-ts-mode . company-mode))
  :mode (("\\.py\\'" . python-ts-mode)))

(use-package typescript-ts-mode
  :hook ((typescript-ts-mode . eglot-ensure)
         (typescript-ts-mode . prettier-js-mode)
         (typescript-ts-mode . company-mode))
  :mode (("\\.ts\\'" . typescript-ts-mode)))

(use-package tsx-ts-mode
  :hook ((tsx-ts-mode . eglot-ensure)
         (tsx-ts-mode . prettier-js-mode)
         (tsx-ts-mode . company-mode))
  :mode (("\\.tsx\\'" . tsx-ts-mode)))


(use-package neotree
  :ensure t
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 55
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action)
        ;; truncate long file names in neotree
        (add-hook 'neo-after-create-hook
           #'(lambda (_)
               (with-current-buffer (get-buffer neo-buffer-name)
                 (setq truncate-lines t)
                 (setq word-wrap nil)
                 (make-local-variable 'auto-hscroll-mode)
                 (setq auto-hscroll-mode nil)))))

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;; (global-set-key (kbd "<f8>") 'neotree-toggle)
(global-set-key (kbd "C-c b") 'neotree-toggle)

;; optionally if you want to use debugger
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
;; (use-package dap-mode
;;   :ensure t)

(use-package magit
  :ensure t)

(use-package flycheck
  :ensure t
  :defer t
  :init (global-flycheck-mode))


(load "prettier-js.el")
(require 'prettier-js)

(provide 'init-development)

;;; init-development.el ends here
