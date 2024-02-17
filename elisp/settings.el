;;; settings.el --- Summary
;;; Commentary:
;;; Code:

(require 'package)
(setq package-enable-at-startup nil)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)
;; first type the above lines and run the init.el script
;; then run M-x package-refresh-contents
;; now can install use-package

;; Disable menus and scrollbars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Disable bell
(setq ring-bell-function 'ignore)

;; Remove lame startup screen
(setq inhibit-startup-message t)

;; Set UTF-8 encoding
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Highligh current line
(when window-system (add-hook 'prog-mode-hook 'hl-line-mode))

;; Disable backups and auto-saves
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Change yes-or-no questions into y-or-n questions
(defalias 'yes-or-no-p 'y-or-n-p)

;; Show line number
(global-display-line-numbers-mode)

;; set relative number
(setq display-line-numbers-type 'relative)

;;show line and column
(setq column-number-mode t)

;;Scroll Smoth
(setq scroll-conservatively 100)

;; Indent Basic
(progn
  ;; make indentation commands use space only (never tab character)
  (setq-default indent-tabs-mode nil)
  ;; emacs 23.1 to 26, default to t
  ;; if indent-tabs-mode is t, it means it may use tab, resulting mixed space and tab
  )

(setq-default tab-width 4) ; emacs 23.1 to 26 default to 8
;; set current buffer's tab char's display width to 4 spaces
(setq tab-width 4)

;;enable all disabled commands in one
(setq disabled-command-function nil)

;; Show Paren Match
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Debug enable
(setq debug-on-error t)

;; Electric Pair mode, provides a way to easily insert matching delimiters
(electric-pair-mode 1)

;; tell Emacs to put all backups that it creates in the TRASH directory.
(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

;; Sort Directories First
(setq dired-listing-switches "-aBhl  --group-directories-first")

;; show whitespaces
;; (global-whitespace-mode t)

;;Default shell should be bash
(defvar my-term-shell "/bin/bash")

(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))

(ad-activate 'ansi-term)

;; global keybinds
(global-set-key (kbd "<M-return>") 'eshell)
(global-set-key (kbd "M-t") 'term)
(global-set-key (kbd "M-s") 'shell)
(global-set-key (kbd "C-S-M-a") 'ansi-term)
(global-set-key (kbd "M-d") 'dashboard-open)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x /") 'comment-line)

;; Zooming In/Out
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; set font
(add-to-list 'default-frame-alist
             '(font . "hack-12"))


;; With Emacs version 29, true transparency has been added.
;; (set-frame-parameter nil 'alpha-background 80)
;; (add-to-list 'default-frame-alist '(alpha-background . 80))

;; Transparency
;; (set-frame-parameter (selected-frame) 'alpha '(85 . 50))
;; (add-to-list 'default-frame-alist '(alpha . (85 . 50)))

(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(85 . 50) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

;; Set transparency of emacs
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))


(provide 'settings)
;;; settings.el ends here
