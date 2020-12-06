;;; init-org-bullets.el --- Summary
;;; Commentary:
;;; Code:


(use-package org-bullets
  :ensure t
  :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(provide 'init-org-bullets)

;;; init-org-bullets.el ends here