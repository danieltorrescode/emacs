(use-package auto-complete 
 :ensure t
:init
(progn
(ac-config-default)
(global-auto-complete-mode t)
))
(ac-config-default)

(global-auto-complete-mode t)
;; Type M-x auto-complete-mode to enable

;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                         (auto-complete-mode 1))
                       ))
(real-global-auto-complete-mode t)

(provide 'init-auto-complete)
