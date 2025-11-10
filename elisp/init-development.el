;;; init-development.el --- Summary -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;;; FLYCHECK
;; (use-package flycheck
;;   :ensure t
;;   :config
;;   ;; (defun my/use-local-eslint ()
;;   ;;   "Find the local eslint executable"
;;   ;;   (interactive)
;;   ;;   (when (and  (projectile-project-p) (member major-mode '(typescript-ts-mode tsx-ts-mode)))
;;   ;;     (let ((path (expand-file-name "node_modules/.bin/eslint" (projectile-project-root))))
;;   ;;       ;; (message "ESLint exec path: %s" path)  ;; Debugging
;;   ;;       (setq flycheck-javascript-eslint-executable path)
;;   ;;       path)))

;;   (defun my/use-local-eslint ()
;;     "Find the local eslint executable using project.el"
;;     (interactive)
;;     (when (and (project-current) (member major-mode '(typescript-ts-mode tsx-ts-mode)))
;;       (let* ((project-root (car (project-roots (project-current))))
;;              (path (expand-file-name "node_modules/.bin/eslint" project-root)))
;;         ;; (message "ESLint exec path: %s" path)  ;; Debugging
;;         (setq flycheck-javascript-eslint-executable path)
;;         path)))


;;   (with-eval-after-load 'flycheck
;;     (setq-default flycheck-disabled-checkers '(typescript-tslint)) ;; Disable TSLint
;;     (flycheck-add-mode 'javascript-eslint 'typescript-ts-mode)     ;; Enable ESLint for TypeScript
;;     (flycheck-add-mode 'javascript-eslint 'tsx-ts-mode)  ;; Enable ESLint for TSX files (React)
;;     (flycheck-add-mode 'javascript-eslint 'js2-mode)
;;     (flycheck-add-mode 'javascript-eslint 'js-mode))

;;   (add-hook 'flycheck-mode-hook #'my/use-local-eslint)
;;   :defer t
;;   :init (global-flycheck-mode))


;;; DAP DEBUGGER
;; optionally if you want to use debugger
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
;; (use-package dap-mode
;;   :ensure t)


;;; ORIGAMI
(use-package origami
  :ensure t
  :hook ((prog-mode . origami-mode))  ;; Enable in programming modes
  :bind (("C-c f t" . origami-toggle-node)   ;; Toggle folding
         ("C-c f o" . origami-open-node)     ;; Open fold
         ("C-c f O" . origami-open-node-recursively)
         ("C-c f c" . origami-close-node)
         ("C-c f C" . origami-close-node-recursively)
         ("C-c f a" . origami-toggle-all-nodes))
  :config
  (message "Origami mode loaded"))

;;; GIT GUTTER
;; === Git Gutter + Fringe for Icons ===
(use-package git-gutter
  :ensure t
  :hook ((prog-mode . git-gutter-mode))  ;; Enable in programming modes
  :bind (("C-x g p" . git-gutter:previous-hunk)
         ("C-x g n" . git-gutter:next-hunk)
         ("C-x g v" . git-gutter:popup-hunk)
         ("C-x g r" . git-gutter:revert-hunk))
  :custom
  (git-gutter:update-interval 1)  ;; Faster updates
  (git-gutter:modified-sign "●")  ;; Custom symbols
  (git-gutter:added-sign "▎")
  (git-gutter:deleted-sign "▁")
  :config
  (message "Git Gutter loaded"))

;; === Git Gutter Fringe (adds icons to the margin) ===
;; (use-package git-gutter-fringe
;;   :ensure t
;;   :after git-gutter
;;   :config
;;   (setq git-gutter-fr:side 'left-fringe)  ;; Show markers in the left fringe
;;   (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
;;   (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
;;   (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

;; === diff-hl: Alternative Git Diff Visualization ===
;; (use-package diff-hl
;;   :ensure t
;;   :hook ((prog-mode . diff-hl-mode)
;;          (magit-post-refresh . diff-hl-magit-post-refresh))
;;   :config
;;   (global-diff-hl-mode)
;;   (diff-hl-flydiff-mode)  ;; Instant visual updates
;;   (diff-hl-margin-mode)   ;; Show in the margin (optional)
;;   (message "diff-hl loaded"))

;; === Automatically Update Git Gutter ===
;; (defun my-git-gutter-update-on-save ()
;;   "Auto-update git-gutter when saving or switching buffers."
;;   (add-hook 'after-save-hook #'git-gutter:update)
;;   (add-hook 'focus-in-hook #'git-gutter:update))

;; (add-hook 'prog-mode-hook #'my-git-gutter-update-on-save)

;;; PRETTIER
(load "prettier-js.el")

(defun project-local-prettier ()
  "Return path to local prettier binary if available, else nil."
  (let* ((root (locate-dominating-file default-directory "node_modules"))
         (prettier (and root
                        (expand-file-name "node_modules/.bin/prettier" root))))
    (when (and prettier (file-executable-p prettier))
      prettier)))

(use-package prettier-js
  :init
  (global-set-key (kbd "C-c I") 'prettier-js)
  :hook ((js-mode . prettier-js-mode)
         (typescript-ts-mode . prettier-js-mode)
         (tsx-ts-mode . prettier-js-mode)
         (json-mode . prettier-js-mode))
  :config
  (defun use-project-prettier-if-available ()
    (setq-local prettier-js-command
                (or (project-local-prettier) "prettier")))
  (add-hook 'prettier-js-mode-hook #'use-project-prettier-if-available))

;;; PROGRAMMING MODES GENERAL CONFIG

;; (setq c-default-style "linux"
;;       c-basic-offset 4)

(use-package c-ts-mode
  :hook ((c-ts-mode . eglot-ensure))
  :mode (("\\.c\\'" . c-ts-mode)))

(use-package html-ts-mode
  :mode (("\\.html\\'" . html-ts-mode)))

(use-package css-ts-mode
  :mode (("\\.css\\'" . css-ts-mode)))

(use-package yaml-ts-mode
  :mode (("\\.yml\\'" . yaml-ts-mode)))

(use-package json-ts-mode
  :mode (("\\.json\\'" . json-ts-mode)))

(use-package sql-mode
  :mode (("\\.sql\\'" . sql-mode)))

(use-package python-ts-mode
  :hook ((python-ts-mode . eglot-ensure))
  :mode (("\\.py\\'" . python-ts-mode)))

(use-package typescript-ts-mode
  :hook ((typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . hs-minor-mode))
  :mode (("\\.ts\\'" . typescript-ts-mode)))

(use-package tsx-ts-mode
  :hook ((tsx-ts-mode . eglot-ensure)
         (tsx-ts-mode . hs-minor-mode))
  :mode (("\\.tsx\\'" . tsx-ts-mode)))


;;;; JS-TS-MODE
;; (use-package js-ts-mode
;;   :ensure js ;; I care about js-base-mode but it is locked behind the feature "js"
;;   :mode "\\.jsx?\\'"
;;   :defer 't
;;   :custom
;;   (js-indent-level 2)
;;   :config
;;   (add-to-list 'treesit-language-source-alist '(javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src"))
;;   (add-to-list 'treesit-language-source-alist '(jsdoc "https://github.com/tree-sitter/tree-sitter-jsdoc" "master" "src")))

;;;; TOML-TS-MODE
;; (use-package toml-ts-mode
;;   :ensure toml-ts-mode
;;   :mode "\\.toml\\'"
;;   :defer 't
;;   :config
;;   (add-to-list 'treesit-language-source-alist '(toml "https://github.com/ikatyang/tree-sitter-toml" "master" "src")))

;;;; MARKDOWN-TS-MODE
;; (use-package markdown-ts-mode
;;   :ensure nil
;;   :mode "\\.md\\'"
;;   :defer 't
;;   :config
;;   (add-to-list 'major-mode-remap-alist '(markdown-mode . markdown-ts-mode))
;;   (add-to-list 'treesit-language-source-alist '(markdown "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown/src"))
;;   (add-to-list 'treesit-language-source-alist '(markdown-inline "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown-inline/src")))

;;;; YAML-TS-MODE
;; (use-package yaml-ts-mode
;;   :ensure yaml-ts-mode
;;   :mode "\\.yml\\'"
;;   :defer 't
;;   :config
;;   (add-to-list 'treesit-language-source-alist '(yaml "https://github.com/ikatyang/tree-sitter-yaml" "master" "src")))

;;;; DOCKERFILE-TS-MODE
;; (use-package dockerfile-ts-mode
;;   :ensure dockerfile-ts-mode
;;   :mode "\\Dockerfile.*\\'"
;;   :defer 't
;;   :config
;;   (add-to-list 'treesit-language-source-alist '(dockerfile "https://github.com/camdencheek/tree-sitter-dockerfile" "main" "src")))



(provide 'init-development)

;;; init-development.el ends here
