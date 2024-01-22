;;; init.el --- Summary
;;; Commentary:
;;; Code:

(add-to-list 'load-path (concat user-emacs-directory "/elisp"))

(require 'settings)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))
(require 'init-evil)
(require 'init-completion)
(require 'init-themes)
(require 'init-development)

;; (unless (package-installed-p 'exwm)
;;   (package-install 'exwm))

;; (require 'exwm)
;; (require 'exwm-config)
;; (require 'init-exwm)

(provide 'init)
;;; init.el ends here
