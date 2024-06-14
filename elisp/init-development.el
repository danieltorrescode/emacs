;;; init-development.el --- Summary
;;; Commentary:
;;; Code:

(setq treesit-language-source-alist
      '((cpp "https://github.com/tree-sitter/tree-sitter-cpp")
        (c "https://github.com/tree-sitter/tree-sitter-c")))

(setq major-mode-remap-alist
      '((c-mode . c-ts-mode)))

(use-package c-ts-mode
  :hook ((c-ts-mode . eglot-ensure)
         (c-ts-mode . company-mode))
  :mode (("\\.c\\'" . c-ts-mode)))

;; ("C-M-s-\\" . eglot-format)

;; (setq c-default-style "linux"
;;       c-basic-offset 4)

;; optionally if you want to use debugger
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
;; (use-package dap-mode
;;   :ensure t)

;; (use-package magit
;;   :ensure t)

;; (use-package flycheck
;;   :ensure t
;;   :defer t
;;   :init (global-flycheck-mode))

(provide 'init-development)

;;; init-development.el ends here
