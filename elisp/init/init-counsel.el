;;; init-counsel.el --- Summary
;;; Commentary:

;; Counsel replace a lot of ido or helms completion functionality

;;; Code:

(use-package counsel
:ensure t
:bind
(("M-y" . counsel-yank-pop)
:map ivy-minibuffer-map
("M-y" . ivy-next-line)))

(provide 'init-counsel)

;;; init-counsel.el ends here