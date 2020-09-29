;; For HTML snippets use Emmet Mode

(use-package yasnippet
    :ensure t
    :init
    (yas-global-mode 1))

(use-package yasnippet-snippets
    :ensure t)

(provide 'init-yasnippet)