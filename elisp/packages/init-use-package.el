;;; use-package.el --- Summary
;;; Commentary:
;;; Code:

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(provide 'init-use-package)

;;; init-use-package.el ends here
