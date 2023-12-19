;;; init-swiper.el --- Summary
;;; Commentary:

;; Swiper gives us a really efficient incremental search
;; with regular expressions

;;; Code:


(use-package swiper
:ensure t
:bind (("C-s" . swiper-isearch)
    ("C-r" . swiper-isearch)
    ("C-c C-r" . ivy-resume)
    ("M-x" . counsel-M-x)
    ("C-x C-f" . counsel-find-file))
:config
(progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

(provide 'init-swiper)

;;; init-swiper.el ends here
