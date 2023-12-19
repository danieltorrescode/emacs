;;; company.el --- Summary
;;; Commentary:
;;; Code:

(use-package company
  :ensure t
  :defer 2
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :ensure t
  :after company
  :hook (company-mode . company-box-mode))

(provide 'init-company)

;;; init-company.el ends here
