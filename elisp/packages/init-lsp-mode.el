;;; lsp-mode.el --- Summary
;;; Commentary:
;;; Code:

(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c-mode . lsp)
         (python-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui
  :commands lsp-ui-mode
  :ensure t)
;; if you are ivy user
(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol
  :ensure t)
;;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode
  :ensure t)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(provide 'init-lsp-mode)

;;; init-lsp-mode.el ends here
