;;; init.el --- Summary -*- lexical-binding: t -*-
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
  "Set ans-term."
  (interactive (list my-term-shell)))

(ad-activate 'ansi-term)

;; enable IDO mode
(ido-mode 1)
(ido-everywhere 1)

;; global keybinds
(global-set-key (kbd "<M-return>") 'eshell)
(global-set-key (kbd "M-t") 'term)
(global-set-key (kbd "M-s") 'shell)
(global-set-key (kbd "C-S-M-a") 'ansi-term)
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


;; IBuffer Config
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("org" (name . "^.*org$"))
               ("magit" (mode . magit-mode))
               ("IRC" (or (mode . circe-channel-mode) (mode . circe-server-mode)))
               ("web" (or (mode . web-mode) (mode . js2-mode)))
               ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
               ("mu4e" (or

                        (mode . mu4e-compose-mode)
                        (name . "\*mu4e\*")
                        ))
               ("programming" (or
                               (mode . typescript-ts-mode)
                               (mode . tsx-ts-mode)
                               (mode . python-ts-mode)
                               (mode . yaml-ts-mode)
                               (mode . bash-ts-mode)
                               (mode . c-ts-mode)))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))
               ))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

;; Don't show filter groups if there are no buffers in that group
(setq ibuffer-show-empty-filter-groups nil)

;; Don't ask for confirmation to delete marked buffers
(setq ibuffer-expert t)


;; With Emacs version 29, true transparency has been added.
;; (set-frame-parameter nil 'alpha-background 80)
;; (add-to-list 'default-frame-alist '(alpha-background . 80))

;; Transparency
;; (set-frame-parameter (selected-frame) 'alpha '(85 . 50))
;; (add-to-list 'default-frame-alist '(alpha . (85 . 50)))

(defvar my-transparency-level 80
  "Default transparency level when toggling transparency.")

(defun transparency (value)
  "Set the transparency VALUE of the frame window.
0 = fully transparent, 100 = fully opaque."
  (interactive "nTransparency Value (0-100): ")
  (setq my-transparency-level value)
  (set-frame-parameter (selected-frame) 'alpha-background value)
  (message "Transparency set to %d" value))

(defun toggle-transparency ()
  "Toggle transparency using `alpha-background` in Emacs 29+.
Respects the value set by `transparency` function."
  (interactive)
  (let* ((current-alpha (frame-parameter nil 'alpha-background))
         (new-alpha (if (or (not current-alpha) (= current-alpha 100))
                        my-transparency-level
                      100)))
    (set-frame-parameter nil 'alpha-background new-alpha)
    (message "Transparency set to %d" new-alpha)))

(global-set-key (kbd "C-c t") 'toggle-transparency)
(global-set-key (kbd "C-c T") 'transparency)  ;; Assign `transparency` to "C-c T"



(require 'org-tempo)
;; org-agenda
(global-set-key (kbd "C-x a") 'org-agenda)
(setq org-agenda-files '("~/Documents/emacs.org"))

(setq
 ;; org-fancy-priorities-list '("[A]" "[B]" "[C]")
 ;; org-fancy-priorities-list '("❗" "[B]" "[C]")
 org-fancy-priorities-list '("🟥" "🟧" "🟨")
 org-priority-faces
 '((?A :foreground "#ff6c6b" :weight bold)
   (?B :foreground "#fdf300" :weight bold)
   (?C :foreground "#39bbfb" :weight bold))
 org-agenda-block-separator 8411)

(setq org-agenda-custom-commands
      '(("v" "Agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (tags "PRIORITY=\"B\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
          (tags "PRIORITY=\"C\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (tags "customtag"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Tasks marked with customtag:")))

          (agenda "")
          (alltodo "")))))

(add-to-list 'load-path (concat user-emacs-directory "/elisp"))

(require 'init-evil)
(require 'init-themes)
(require 'init-completion)
(require 'init-development)
(require 'init-rss-reader)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(org-agenda-files '("~/Documents/emacs.org"))
 '(package-selected-packages
   '(all-the-icons-dired all-the-icons-ivy company-box counsel dashboard
                         doom-modeline elfeed-goodies evil-collection
                         flycheck magit neotree org-bullets
                         treemacs-evil treemacs-icons-dired
                         treemacs-projectile undo-tree)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
