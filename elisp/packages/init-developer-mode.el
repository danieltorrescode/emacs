;;; init-developer-mode.el --- Summary
;;; Commentary:
;;; Code:


(setq c-default-style "linux"
      c-basic-offset 4)

(unless (package-installed-p 'prettier-js)
  (package-install 'prettier-js))

(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)


(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred

(provide 'init-developer-mode)

;;; init-developer-mode.el ends here
