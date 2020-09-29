;; Counsel replace a lot of ido or helms completion functionality

(use-package counsel
:ensure t
:bind
(("M-y" . counsel-yank-pop)
:map ivy-minibuffer-map
("M-y" . ivy-next-line)))

(provide 'init-counsel)