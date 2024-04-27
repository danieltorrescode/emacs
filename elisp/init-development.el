;;; init-development.el --- Summary
;;; Commentary:
;;; Code:

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (cmake "https://github.com/uyha/tree-sitter-cmake")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (go "https://github.com/tree-sitter/tree-sitter-go")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (make "https://github.com/alemuller/tree-sitter-make")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")))

(setq major-mode-remap-alist
      '((javascript-mode . javascript-ts-mode)
        ))



(use-package javascript-ts-mode
  :hook ((javascript-ts-mode . eglot-ensure)
         (javascript-ts-mode . company-mode))
  :mode (("\\.js\\'" . javascript-ts-mode)))


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

;; (use-package lsp-mode
;;   :ensure t
;;   :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   (setq lsp-keymap-prefix "C-c l")
;;   :hook (
;;          ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          (c-mode . lsp)
;;          (python-mode . lsp)
;;          ;; if you want which-key integration
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :commands lsp)

;; ;; optionally
;; (use-package lsp-ui
;;   :commands lsp-ui-mode
;;   :ensure t)
;; ;; if you are ivy user
;; (use-package lsp-ivy
;;   :commands lsp-ivy-workspace-symbol
;;   :ensure t)
;; ;;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; (use-package lsp-pyright
;;   :ensure t
;;   :hook (python-mode . (lambda ()
;;                          (require 'lsp-pyright)
;;                          (lsp))))  ; or lsp-deferred


(provide 'init-development)

;;; init-development.el ends here
