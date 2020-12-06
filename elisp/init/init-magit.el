;;; init-magit.el --- Summary
;;; Commentary:
;;; Code:


(unless (package-installed-p 'magit)
  (package-install 'magit))

(provide 'init-magit)

;;; init-magit.el ends here