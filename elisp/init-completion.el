;;; init-completion.el --- Summary
;;; Commentary:
;;; Code:

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; (use-package which-key-posframe		;
;;      :ensure t
;;      :config
;;      (which-key-posframe-mode))

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

;; (use-package company
;;   :ensure t
;;   :defer 2
;;   :custom
;;   (company-begin-commands '(self-insert-command))
;;   (company-idle-delay .1)
;;   (company-minimum-prefix-length 2)
;;   (company-show-numbers t)
;;   (company-tooltip-align-annotations 't)
;;   (global-company-mode t))

;; (use-package company-box
;;   :ensure t
;;   :after company
;;   :hook (company-mode . company-box-mode))


(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-display-style 'fancy))


(use-package counsel
  :ensure t
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))


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

(provide 'init-completion)

;;; init-completion.el ends here
