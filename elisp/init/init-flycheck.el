;;; init-flycheck.el --- Summary
;;; Commentary:

;; *NOTES*: 
;; npm install eslint
;; pip install pylint
;; pip install --upgrade autopep8

;;; Code:

(use-package flycheck
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode))

(provide 'init-flycheck)

;;; init-flycheck.el ends here