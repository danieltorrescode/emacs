;;; init-got-chg.el --- Summary
;;; Commentary:
;;; Code:

(unless (package-installed-p 'goto-chg)
  (package-install 'goto-chg))

(require 'goto-chg)

(provide 'init-goto-chg)

;;; init-goto-chg.el ends here
