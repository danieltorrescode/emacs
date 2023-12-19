;;; undo-tree.el --- Treat undo history as a tree  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))

(require 'undo-tree)

(provide 'init-undo-tree)

;;; init-undo-tree.el ends here
