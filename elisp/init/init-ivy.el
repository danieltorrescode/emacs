;;; init-ivy.el --- Summary
;;; Commentary:
;; Ivy / Counsel replace a lot of ido or helms completion functionality

;;; Code:

(use-package ivy
:ensure t
:diminish (ivy-mode)
:bind (("C-x b" . ivy-switch-buffer))
:config
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "%d/%d ")
(setq ivy-display-style 'fancy))

(provide 'init-ivy)

;;; init-ivy.el ends here