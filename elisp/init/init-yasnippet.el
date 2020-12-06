;;; init-yasnippet.el --- Summary
;;; Commentary:

;; For HTML snippets use Emmet Mode

;;; Code:


(use-package yasnippet
    :ensure t
    :init
    (yas-global-mode 1))

(use-package yasnippet-snippets
    :ensure t)

(provide 'init-yasnippet)

;;; init-yasnippet.el ends here