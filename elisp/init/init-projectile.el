;;This makes sure that everything can be a project.
(use-package projectile
    :ensure t
    :init
        (projectile-mode 1))

;; Let projectile call make
(global-set-key (kbd "<f5>") 'projectile-compile-project)

(provide 'init-projectile)