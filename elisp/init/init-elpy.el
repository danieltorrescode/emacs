;;; init-elpy.el --- Summary
;;; Commentary:
;;; Code:

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;; Enable autopep8
(require 'py-autopep8)
(require 'blacken)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(provide 'init-elpy)

;;; init-elpy.el ends here