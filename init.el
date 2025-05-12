;;; init.el --- Configuration  -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:

(require 'package)
(setq package-enable-at-startup nil)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)
;; first type the above lines and run the init.el script
;; then run M-x package-refresh-contents

;;; -------------------- GENERAL EMACS CONFIG
;;; EMACS
(use-package emacs
  :ensure nil
  :bind
  (("M-o" . other-window)
   ("M-j" . duplicate-dwim)
   ("M-g r" . recentf)
   ("M-s g" . grep)
   ("M-s C-g" . rgrep)
   ("M-s f" . find-name-dired)
   ("C-x C-b" . ibuffer)
   ("RET" . newline-and-indent)
   ("C-z" . nil)
   ("C-x C-z" . nil)
   ("C-x C-k RET" . nil))
  :custom
  (ad-redefinition-action 'accept)
  (column-number-mode t)
  (line-number-mode nil)
  (completion-ignore-case t)
  (completions-detailed t)
  (completions-format 'one-column)
  (delete-by-moving-to-trash t)
  (display-line-numbers-width 3)
  (display-line-numbers-widen t)
  (delete-selection-mode 1)
  (enable-recursive minibuffers t)
  (find-ls-option '("-exec ls -ldh {} +" . "-ldh"))  ; find-dired results with human readable sizes
  (frame-resize-pixelwise t)
  (global-auto-revert-non-file-buffers t)
  (help-window-select t)
  (history-length 300)
  (inhibit-startup-message t)
  (initial-scratch-message "")
  (ispell-dictionary "en_US")
  (kill-do-not-save-duplicates t)
  (create-lockfiles nil)   ; No backup files
  (make-backup-files nil)  ; No backup files
  (backup-inhibited t)     ; No backup files
  (auto-save-default nil)
  (scroll-conservatively 100)
  (pixel-scroll-precision-mode t)
  (pixel-scroll-precision-use-momentum nil)
  (ring-bell-function 'ignore)
  (read-answer-short t)
  (recentf-max-saved-items 300) ; default is 20
  (recentf-max-menu-items 15)
  (recentf-auto-cleanup (if (daemonp) 300 'never))
  (recentf-exclude (list "^/\\(?:ssh\\|su\\|sudo\\)?:"))
  (remote-file-name-inhibit-delete-by-moving-to-trash t)
  (remote-file-name-inhibit-auto-save t)
  (resize-mini-windows 'grow-only)
  (ring-bell-function #'ignore)
  (savehist-save-minibuffer-history t)    ; t is default
  (savehist-additional-variables
   '(kill-ring                            ; clipboard
     register-alist                       ; macros
     mark-ring global-mark-ring           ; marks
     search-ring regexp-search-ring))     ; searches
  (save-place-file (expand-file-name "saveplace" user-emacs-directory))
  (save-place-limit 600)
  (set-mark-command-repeat-pop t) ; So we can use C-u C-SPC C-SPC C-SPC... instead of C-u C-SPC C-u C-SPC...
  (split-width-threshold 170)     ; So vertical splits are preferred
  (split-height-threshold nil)
  (shr-use-colors nil)
  (switch-to-buffer-obey-display-actions t)
  (tab-always-indent 'complete)
  (tab-width 4)
  (tab-bar-close-button-show nil)
  (tab-bar-new-button-show nil)
  (tab-bar-tab-hints t)
  (treesit-font-lock-level 4)
  (truncate-lines t)
  (undo-limit (* 13 160000))
  (undo-strong-limit (* 13 240000))
  (undo-outer-limit (* 13 24000000))
  (use-dialog-box nil)
  (use-file-dialog nil)
  (use-short-answers t)
  (visible-bell nil)
  (window-combination-resize t)
  (window-resize-pixelwise nil)
  (xref-search-program 'ripgrep)
  (grep-command "grep -nH -e ")
  (grep-find-ignored-directories
   '("SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "node_modules" "build" "dist"))
  :config
  ;; Makes everything accept utf-8 as default, so buffers with tsx and so
  ;; won't ask for encoding (because undecided-unix) every single keystroke
  (modify-coding-system-alist 'file "" 'utf-8)

  (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 105)
  ;; set font
  (add-to-list 'default-frame-alist
               '(font . "hack-12"))

  ;; Indent Basic
  (progn
    ;; make indentation commands use space only (never tab character)
    (setq-default indent-tabs-mode nil)
    ;; emacs 23.1 to 26, default to t
    ;; if indent-tabs-mode is t, it means it may use tab, resulting mixed space and tab
    )

  ;;enable all disabled commands in one
  (setq disabled-command-function nil)
  ;; Debug enable
  (setq debug-on-error t)
  ;; tell Emacs to put all backups that it creates in the TRASH directory.
  (setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

  ;; Highligh current line
  (when window-system (add-hook 'prog-mode-hook 'hl-line-mode))

  (when (eq system-type 'darwin)
    (setq insert-directory-program "gls")
    (setq mac-command-modifier 'meta)
    (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 140))

  ;; Save manual customizations to other file than init.el
  (setq custom-file (locate-user-emacs-file "custom-vars.el"))
  (load custom-file 'noerror 'nomessage)

  ;; Set line-number-mode with relative numbering
  (setq display-line-numbers-type 'relative)

  ;; Add option "d" to whenever using C-x s or C-x C-c, allowing a quick preview
  ;; of the diff of what you're asked to save.
  (add-to-list 'save-some-buffers-action-alist
               (list "d"
                     (lambda (buffer) (diff-buffer-with-file (buffer-file-name buffer)))
                     "show diff between the buffer and its file"))

  ;; On Terminal: changes the vertical separator to a full vertical line
  ;;              and truncation symbol to a right arrow
  (set-display-table-slot standard-display-table 'vertical-border ?\u2502)
  (set-display-table-slot standard-display-table 'truncation ?\u2192)

  ;; Ibuffer filters
  (setq ibuffer-saved-filter-groups
        '(("default"
           ("org" (or
                   (mode . org-mode)
                   (name . "^\\*Org Src")
                   (name . "^\\*Org Agenda\\*$")))
           ("tramp" (name . "^\\*tramp.*"))
           ("emacs" (or
                     (name . "^\\*scratch\\*$")
                     (name . "^\\*Messages\\*$")
                     (name . "^\\*Warnings\\*$")
                     (name . "^\\*Shell Command Output\\*$")
                     (name . "^\\*Async-native-compile-log\\*$")
                     (name . "^\\*straight-")))

            ("programming" (or
                            (mode . typescript-ts-mode)
                            (mode . tsx-ts-mode)
                            (mode . python-ts-mode)
                            (mode . yaml-ts-mode)
                            (mode . bash-ts-mode)
                            (mode . c-ts-mode)))
           ("magit" (mode . magit-mode))
           ("ediff" (or
                     (name . "^\\*ediff.*")
                     (name . "^\\*Ediff.*")))
           ("dired" (mode . dired-mode))
           ("terminal" (or
                        (mode . term-mode)
                        (mode . shell-mode)
                        (mode . eshell-mode)))
           ("help" (or
                    (name . "^\\*Help\\*$")
                    (name . "^\\*info\\*$")
                    (name . "^\\*helpful"))))))
  (add-hook 'ibuffer-mode-hook
            (lambda ()
              (ibuffer-switch-to-saved-filter-groups "default")))
  ;; Don't show filter groups if there are no buffers in that group
  (setq ibuffer-show-empty-filter-groups nil)
  ;; Don't ask for confirmation to delete marked buffers
  (setq ibuffer-expert t)

  ;; So eshell git commands open an instance of THIS config of Emacs
  (setenv "GIT_EDITOR" (format "emacs --init-dir=%s " (shell-quote-argument user-emacs-directory)))
  ;; So rebase from eshell opens with a bit of syntax highlight
  (add-to-list 'auto-mode-alist '("/git-rebase-todo\\'" . conf-mode))


  ;; Runs 'private.el' after Emacs inits
  (add-hook 'after-init-hook
            (lambda ()
              (let ((private-file (expand-file-name "private.el" user-emacs-directory)))
                (when (file-exists-p private-file)
                  (load private-file)))))

  :init
  (set-window-margins (selected-window) 2 0)

  (toggle-frame-maximized)
  (select-frame-set-input-focus (selected-frame))
  (global-auto-revert-mode 1)
  (indent-tabs-mode -1)
  (recentf-mode 1)
  (repeat-mode 1)
  (savehist-mode 1)
  (save-place-mode 1)
  (winner-mode)
  (xterm-mouse-mode 1)
  (file-name-shadow-mode 1) ; allows us to type a new path without having to delete the current one
  (global-display-line-numbers-mode t)

  ;; enable IDO mode
  (ido-mode 1)
  (ido-everywhere 1)

  ;;Default shell should be bash
  (defvar my-term-shell "/bin/bash")

  (defadvice ansi-term (before force-bash)
    "Set ans-term."
    (interactive (list my-term-shell)))

  (ad-activate 'ansi-term)

  ;; With Emacs version 29, true transparency has been added.
  ;; (set-frame-parameter nil 'alpha-background 80)
  ;; (add-to-list 'default-frame-alist '(alpha-background . 80))

  ;; Transparency
  ;; (set-frame-parameter (selected-frame) 'alpha '(85 . 50))
  ;; (add-to-list 'default-frame-alist '(alpha . (85 . 50)))

  (defvar my-transparency-level 50
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

  ;; global keybinds
  (global-set-key (kbd "<M-return>") 'eshell)
  (global-set-key (kbd "M-t") 'term)
  ;; (global-set-key (kbd "M-s") 'shell)
  (global-set-key (kbd "C-S-M-a") 'ansi-term)
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  ;; (global-set-key (kbd "C-x /") 'comment-line)

  ;; Zooming In/Out
  (global-set-key (kbd "C-+") 'text-scale-increase)
  (global-set-key (kbd "C--") 'text-scale-decrease)
  (global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
  (global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

  (with-current-buffer (get-buffer-create "*scratch*")
    (insert (format ";;
;; ███████╗███╗   ███╗ █████╗  ██████╗███████╗
;; ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝
;; █████╗  ██╔████╔██║███████║██║     ███████╗
;; ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║
;; ███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║
;; ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
;;
;;   Loading time : %s
;;   Packages     : %s
;;
"
                    (emacs-init-time)
                    (number-to-string (length package-activated-list)))))

  (message (emacs-init-time)))


;;; -------------------- END GENERAL EMACS CONFIG

;;; CONF
(use-package conf-mode
  :ensure nil
  :mode ("\\.env\\..*\\'" "\\.env\\'")
  :init
  (add-to-list 'auto-mode-alist '("\\.env\\'" . conf-mode)))


;;; COMPILATION
(use-package compile
  :ensure nil
  :hook
  (;; Not ideal, but I do not want this poluting the modeline
   (compilation-start . (lambda () (setq compilation-in-progress nil))))
  :custom
  (compilation-always-kill t)
  (compilation-scroll-output t)
  (ansi-color-for-compilation-mode t)
  :config
  (add-hook 'compilation-filter-hook #'ansi-color-compilation-filter))


;;; WINDOW
(use-package window
  :ensure nil
  :custom
  (display-buffer-alist
   '(
     ;; ("\\*.*e?shell\\*"
     ;;  (display-buffer-in-side-window)
     ;;  (window-height . 0.25)
     ;;  (side . bottom)
     ;;  (slot . -1))
     ("\\*\\(Backtrace\\|Warnings\\|Compile-Log\\|Messages\\|Bookmark List\\|Occur\\|eldoc\\)\\*"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 0))
     ("\\*\\([Hh]elp\\)\\*"
      (display-buffer-in-side-window)
      (window-width . 75)
      (side . right)
      (slot . 0))
     ;; ("\\*\\(Ibuffer\\)\\*"
     ;;  (display-buffer-in-side-window)
     ;;  (window-width . 100)
     ;;  (side . right)
     ;;  (slot . 1))
     ("\\*\\(Flymake diagnostics\\|xref\\|Completions\\)"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 1))
     ("\\*\\(grep\\|find\\)\\*"
      (display-buffer-in-side-window)
      (window-height . 0.25)
      (side . bottom)
      (slot . 2))
     )))



;;; DIRED
(use-package dired
  :ensure nil
  :bind
  (("M-i" . emacs/window-dired-vc-root-left))
  :custom
  (dired-dwim-target t)
  (dired-guess-shell-alist-user
   '(("\\.\\(png\\|jpe?g\\|tiff\\)" "feh" "xdg-open" "open")
     ("\\.\\(mp[34]\\|m4a\\|ogg\\|flac\\|webm\\|mkv\\)" "mpv" "xdg-open" "open")
     (".*" "xdg-open" "open")))
  (dired-kill-when-opening-new-dired-buffer t)
  ;; (dired-listing-switches "-al --group-directories-first")
  ;; Sort Directories First
  (dired-listing-switches "-aBhl --group-directories-first")
  :init
  (defun emacs/dired-rsync-copy (dest)
  "Copy marked files in Dired to DEST using rsync asynchronously, with real-time processing of output."
  (interactive
   (list (expand-file-name (read-file-name "rsync to: "
                                           (dired-dwim-target-directory)))))
  (let* ((files (dired-get-marked-files nil current-prefix-arg))
         (command (append '("rsync" "-hPur") (mapcar #'shell-quote-argument files) (list (shell-quote-argument dest))))
         (buffer (get-buffer-create "*rsync*")))
    (with-current-buffer buffer
      (erase-buffer)
      (insert "Running rsync...\n"))

    (defun rsync-process-filter (proc string)
      (with-current-buffer (process-buffer proc)
        (goto-char (point-max))
        (insert string)
        (goto-char (point-max))
        (while (re-search-backward "\r" nil t)
          (replace-match "\n" nil nil))))

    (make-process
     :name "dired-rsync"
     :buffer buffer
     :command command
     :filter 'rsync-process-filter
     :sentinel
     (lambda (_proc event)
       (when (string-match-p "finished" event)
         (with-current-buffer buffer
           (goto-char (point-max))
           (insert "\n* rsync done *\n"))
         (dired-revert)))
     :stderr buffer)

    (display-buffer buffer)
    (message "rsync started...")))


  (defun emacs/window-dired-vc-root-left (&optional directory-path)
    "Creates *Dired-Side* like an IDE side explorer"
    (interactive)
    (add-hook 'dired-mode-hook 'dired-hide-details-mode)

    (let ((dir (if directory-path
                   (dired-noselect directory-path)
         (if (eq (vc-root-dir) nil)
                     (dired-noselect default-directory)
                   (dired-noselect (vc-root-dir))))))

      (display-buffer-in-side-window
       dir `((side . left)
         (slot . 0)
         (window-width . 30)
         (window-parameters . ((no-other-window . t)
                   (no-delete-other-windows . t)
                   (mode-line-format . (" "
                            "%b"))))))
      (with-current-buffer dir
    (let ((window (get-buffer-window dir)))
          (when window
            (select-window window)
        (rename-buffer "*Dired-Side*")
        )))))

  (defun emacs/window-dired-open-directory ()
    "Open the current directory in *Dired-Side* side window."
    (interactive)
    (emacs/window-dired-vc-root-left (dired-get-file-for-visit)))

  (eval-after-load 'dired
  '(progn
     (define-key dired-mode-map (kbd "G") 'emacs/window-dired-open-directory))))


;;; WDIRED
(use-package wdired
  :ensure nil
  :commands (wdired-change-to-wdired-mode)
  :config
  (setq wdired-allow-to-change-permissions t)
  (setq wdired-create-parent-directories t))


;;; ESHELL
(use-package eshell
  :ensure nil
  :defer t
  :config
  (defun emacs/eshell-pick-history ()
    "Show Eshell history in a completing-read picker and insert the selected command."
    (interactive)
    (let* ((history-file (expand-file-name "eshell/history" user-emacs-directory))
           (history-entries (when (file-exists-p history-file)
                              (with-temp-buffer
                                (insert-file-contents history-file)
                                (split-string (buffer-string) "\n" t))))
           (selection (completing-read "Eshell History: " history-entries)))
      (when selection
        (insert selection))))


  (defun eshell/cat-with-syntax-highlighting (filename)
    "Like cat(1) but with syntax highlighting.
  Stole from aweshell"
    (let ((existing-buffer (get-file-buffer filename))
          (buffer (find-file-noselect filename)))
      (eshell-print
       (with-current-buffer buffer
         (if (fboundp 'font-lock-ensure)
             (font-lock-ensure)
           (with-no-warnings
             (font-lock-fontify-buffer)))
         (let ((contents (buffer-string)))
           (remove-text-properties 0 (length contents) '(read-only nil) contents)
           contents)))
      (unless existing-buffer
        (kill-buffer buffer))
      nil))
  (advice-add 'eshell/cat :override #'eshell/cat-with-syntax-highlighting)


  (add-hook 'eshell-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c l") #'emacs/eshell-pick-history)
              (local-set-key (kbd "C-l")
                             (lambda ()
                               (interactive)
                               (eshell/clear 1)
                               (eshell-send-input)))))

  (require 'vc)
  (require 'vc-git)
  (setopt eshell-prompt-function
        (lambda ()
          (concat
           "("
           (if (> eshell-last-command-status 0)
               "❌"
             "🐂")
           " " (number-to-string eshell-last-command-status)
           ;; ")──("
           ;; "🧘 " (or (file-remote-p default-directory 'user) (user-login-name))
           ;; ")──("
           ;; "💻 " (or (file-remote-p default-directory 'host) (system-name))
           ;; ")──("
           ;; "🕝 " (format-time-string "%H:%M:%S" (current-time))
           ")──("
           "📁 "
           (concat (if (>= (length (eshell/pwd)) 40)
                       (concat "..." (car (last (butlast (split-string (eshell/pwd) "/") 0))))
                     (abbreviate-file-name (eshell/pwd))))
           ;; ")\n"
           ")"

           (when (and (fboundp 'vc-git-root) (vc-git-root default-directory))
             (concat
              "──( " (car (vc-git-branches))
              (let* ((branch (car (vc-git-branches)))
                     (behind (string-to-number
                              (shell-command-to-string
                               (concat "git rev-list --count HEAD..origin/" branch)))))
                (if (> behind 0)
                    (concat "  ⬇️ " (number-to-string behind))))

              (let ((modified (length (split-string
                                       (shell-command-to-string
                                        "git ls-files --modified") "\n" t)))
                    (untracked (length (split-string
                                        (shell-command-to-string
                                         "git ls-files --others --exclude-standard") "\n" t))))
                (concat
                 (if (> modified 0)
                     (concat "  ✏️ " (number-to-string modified)))
                 (if (> untracked 0)
                     (concat "  📄 " ))))
              ")"))
           " >\n ")))

  (setq eshell-prompt-regexp "└─➜ ")

  (add-hook 'eshell-mode-hook (lambda () (setenv "TERM" "xterm-256color")))

  (setq eshell-visual-commands
        '("vi" "screen" "top"  "htop" "btm" "less" "more" "lynx" "ncftp" "pine" "tin" "trn"
          "elm" "irssi" "nmtui-connect" "nethack" "vim" "alsamixer" "nvim" "w3m"
          "ncmpcpp" "newsbeuter" "nethack" "mutt")))

;;; ISEARCH
(use-package isearch
  :ensure nil
  :config
  (setq isearch-lazy-count t)
  (setq lazy-count-prefix-format "(%s/%s) ")
  (setq lazy-count-suffix-format nil)
  (setq search-whitespace-regexp ".*?")

  (defun isearch-copy-selected-word ()
    "Copy the current `isearch` selection to the kill ring."
    (interactive)
    (when isearch-other-end
      (let ((selection (buffer-substring-no-properties isearch-other-end (point))))
        (kill-new selection)
        (isearch-exit))))

  ;; Bind `M-w` in isearch to copy the selected word, so M-s M-. M-w
  ;; does a great job of 'copying the current word under cursor'.
  (define-key isearch-mode-map (kbd "M-w") 'isearch-copy-selected-word))


;;; VC
(use-package vc
  :ensure nil
  :defer t
  :config
  (setopt
   vc-git-diff-switches '("--patch-with-stat" "--histogram")  ;; add stats to `git diff'
   vc-git-log-switches '("--stat")                            ;; add stats to `git log'
   vc-git-log-edit-summary-target-len 50
   vc-git-log-edit-summary-max-len 70
   vc-git-print-log-follow t
   vc-git-revision-complete-only-branches nil
   vc-annotate-display-mode 'scale
   add-log-keep-changes-together t
   vc-make-backup-files nil)                                  ;; Do not backup version controlled files

  (with-eval-after-load 'vc-annotate
    (setopt vc-annotate-color-map
          '((20 . "#c3e88d")
            (40 . "#89DDFF")
            (60 . "#82aaff")
            (80 . "#676E95")
            (100 . "#c792ea")
            (120 . "#f78c6c")
            (140 . "#79a8ff")
            (160 . "#f5e0dc")
            (180 . "#a6e3a1")
            (200 . "#94e2d5")
            (220 . "#89dceb")
            (240 . "#74c7ec")
            (260 . "#82aaff")
            (280 . "#b4befe")
            (300 . "#b5b0ff")
            (320 . "#8c9eff")
            (340 . "#6a81ff")
            (360 . "#5c6bd7"))))

  ;; This one is for editing commit messages
  (require 'log-edit)
  (setopt log-edit-confirm 'changed
          log-edit-keep-buffer nil
          log-edit-require-final-newline t
          log-edit-setup-add-author nil)

  ;; Removes the bottom window with modified files list
  (remove-hook 'log-edit-hook #'log-edit-show-files)

  (with-eval-after-load 'vc-dir
    ;; In vc-git and vc-dir for git buffers, make (C-x v) a run git add, u run git
    ;; reset, and r run git reset and checkout from head.
    (defun emacs/vc-git-command (verb fn)
      "Execute a Git command with VERB as action description and FN as operation on files."
      (let* ((fileset (vc-deduce-fileset t)) ;; Deduce fileset
             (backend (car fileset))
             (files (nth 1 fileset)))
        (if (eq backend 'Git)
            (progn
              (funcall fn files)
              (message "%s %d file(s)." verb (length files)))
          (message "Not in a VC Git buffer."))))

    (defun emacs/vc-git-add (&optional revision vc-fileset comment)
      (interactive "P")
      (emacs/vc-git-command "Staged" 'vc-git-register))

    (defun emacs/vc-git-reset (&optional revision vc-fileset comment)
      (interactive "P")
      (emacs/vc-git-command "Unstaged"
                                 (lambda (files) (vc-git-command nil 0 files "reset" "-q" "--"))))


    ;; Bind S and U in vc-dir-mode-map
    (define-key vc-dir-mode-map (kbd "S") #'emacs/vc-git-add)
    (define-key vc-dir-mode-map (kbd "U") #'emacs/vc-git-reset)

    ;; Bind S and U in vc-prefix-map for general VC usage
    (define-key vc-prefix-map (kbd "S") #'emacs/vc-git-add)
    (define-key vc-prefix-map (kbd "U") #'emacs/vc-git-reset)

    ;; Bind g to hide up to date files after refreshing in vc-dir
    (define-key vc-dir-mode-map (kbd "g")
                (lambda () (interactive) (vc-dir-refresh) (vc-dir-hide-up-to-date)))


    (defun emacs/vc-git-visualize-status ()
      "Show the Git status of files in the `vc-log` buffer."
      (interactive)
      (let* ((fileset (vc-deduce-fileset t))
             (backend (car fileset))
             (files (nth 1 fileset)))
        (if (eq backend 'Git)
            (let ((output-buffer "*Git Status*"))
              (with-current-buffer (get-buffer-create output-buffer)
                (read-only-mode -1)
                (erase-buffer)
                ;; Capture the raw output including colors using 'git status --color=auto'
                (call-process "git" nil output-buffer nil "status" "-v")
                (pop-to-buffer output-buffer)))
          (message "Not in a VC Git buffer."))))

    (define-key vc-dir-mode-map (kbd "V") #'emacs/vc-git-visualize-status)
    (define-key vc-prefix-map (kbd "V") #'emacs/vc-git-visualize-status))

  (defun emacs/vc-git-reflog ()
    "Show git reflog in a new buffer with ANSI colors and custom keybindings."
    (interactive)
    (let* ((root (vc-root-dir)) ;; Capture VC root before creating buffer
           (buffer (get-buffer-create "*vc-git-reflog*")))
      (with-current-buffer buffer
        (setq-local vc-git-reflog-root root) ;; Store VC root as a buffer-local variable
        (let ((inhibit-read-only t))
          (erase-buffer)
          (vc-git-command buffer nil nil
                          "reflog"
                          "--color=always"
                          "--pretty=format:%C(yellow)%h%Creset %C(auto)%d%Creset %Cgreen%gd%Creset %s %Cblue(%cr)%Creset")
          (goto-char (point-min))
          (ansi-color-apply-on-region (point-min) (point-max)))

        (let ((map (make-sparse-keymap)))
          (define-key map (kbd "/") #'isearch-forward)
          (define-key map (kbd "p") #'previous-line)
          (define-key map (kbd "n") #'next-line)
          (define-key map (kbd "q") #'kill-buffer-and-window)

          (use-local-map map))

        (setq buffer-read-only t)
        (setq mode-name "Git-Reflog")
        (setq major-mode 'special-mode))
      (pop-to-buffer buffer)))
  (global-set-key (kbd "C-x v R") 'emacs/vc-git-reflog)


  (defun emacs/vc-pull-merge-current-branch ()
  "Pull the latest change from origin for the current branch and display output in a buffer."
  (interactive)
  (let* ((branch (vc-git--symbolic-ref "HEAD"))
         (buffer (get-buffer-create "*Git Pull Output*"))
         (command (format "git pull origin %s" branch)))
    (if branch
        (progn
          (with-current-buffer buffer
            (erase-buffer)
            (insert (format "$ %s\n\n" command))
            (call-process-shell-command command nil buffer t))
          (display-buffer buffer))
      (message "Could not determine current branch."))))


  (defun emacs/vc-browse-remote (&optional current-line)
  "Open the repository's remote URL in the browser.
If CURRENT-LINE is non-nil, point to the current branch, file, and line.
Otherwise, open the repository's main page."
  (interactive "P")
  (let* ((remote-url (string-trim (vc-git--run-command-string nil "config" "--get" "remote.origin.url")))
         (branch (string-trim (vc-git--run-command-string nil "rev-parse" "--abbrev-ref" "HEAD")))
         (file (string-trim (file-relative-name (buffer-file-name) (vc-root-dir))))
         (line (line-number-at-pos)))
    (message "Opening remote on browser: %s" remote-url)
    (if (and remote-url (string-match "\\(?:git@\\|https://\\)\\([^:/]+\\)[:/]\\(.+?\\)\\(?:\\.git\\)?$" remote-url))
        (let ((host (match-string 1 remote-url))
              (path (match-string 2 remote-url)))
          ;; Convert SSH URLs to HTTPS (e.g., git@github.com:user/repo.git -> https://github.com/user/repo)
          (when (string-prefix-p "git@" host)
            (setq host (replace-regexp-in-string "^git@" "" host)))
          ;; Construct the appropriate URL based on CURRENT-LINE
          (browse-url
           (if current-line
               (format "https://%s/%s/blob/%s/%s#L%d" host path branch file line)
             (format "https://%s/%s" host path))))
      (message "Could not determine repository URL"))))
  (global-set-key (kbd "C-x v B") 'emacs/vc-browse-remote)
  (global-set-key (kbd "C-x v o")
                  '(lambda () (interactive) (emacs/vc-browse-remote 1)))


  (defun emacs/vc-diff-on-current-hunk ()
    "Show the diff for the current file and jump to the hunk containing the current line."
    (interactive)
    (let ((current-line (line-number-at-pos)))
      (message "Current line in file: %d" current-line)
      (vc-diff) ; Generate the diff buffer
      (with-current-buffer "*vc-diff*"
        (goto-char (point-min))
        (let ((found-hunk nil))
          (while (and (not found-hunk)
                      (re-search-forward "^@@ -\\([0-9]+\\), *[0-9]+ \\+\\([0-9]+\\), *\\([0-9]+\\) @@" nil t))
            (let* ((start-line (string-to-number (match-string 2)))
                   (line-count (string-to-number (match-string 3)))
                   (end-line (+ start-line line-count)))
              (message "Found hunk: %d to %d" start-line end-line)
              (when (and (>= current-line start-line)
                         (<= current-line end-line))
                (message "Current line %d is within hunk range %d to %d" current-line start-line end-line)
                (setq found-hunk t)
                (goto-char (match-beginning 0))))) ; Jump to the beginning of the hunk
          (unless found-hunk
            (message "Current line %d is not within any hunk range." current-line)
            (goto-char (point-min)))))))
  (global-set-key (kbd "C-x v =") 'emacs/vc-diff-on-current-hunk))

;;; SMERGE
(use-package smerge-mode
  :ensure nil
  :bind (:map smerge-mode-map
              ("C-c ^ u" . smerge-keep-upper)
              ("C-c ^ l" . smerge-keep-lower)
              ("C-c ^ n" . smerge-next)
              ("C-c ^ p" . smerge-previous)))

;;; DIFF
(use-package diff-mode
  :ensure nil
  :defer t
  :config
  (setq diff-default-read-only t)
  (setq diff-advance-after-apply-hunk t)
  (setq diff-update-on-the-fly t)
  (setq diff-font-lock-syntax 'hunk-also)
  (setq diff-font-lock-prettify nil))

;;; EDIFF
(use-package ediff
  :ensure nil
  :commands (ediff-buffers ediff-files ediff-buffers3 ediff-files3)
  :init
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  :config
  (setq ediff-keep-variants nil)
  (setq ediff-make-buffers-readonly-at-startup nil)
  (setq ediff-merge-revisions-with-ancestor t)
  (setq ediff-show-clashes-only t))

;;; ELDOC
(use-package eldoc
  :ensure nil
  :init
  (global-eldoc-mode))

;;; EGLOT
(use-package eglot
  :ensure nil
  :custom
  (eglot-autoshutdown t)
  (eglot-events-buffer-size 0)
  (eglot-events-buffer-config '(:size 0 :format full))
  (eglot-prefer-plaintext t)
  (jsonrpc-event-hook nil)
  (eglot-code-action-indications nil) ;; Emacs 31 -- annoying as hell
  :init
  (fset #'jsonrpc--log-event #'ignore)

  (defun emacs/eglot-setup ()
    "Setup eglot mode with specific exclusions."
    (unless (eq major-mode 'emacs-lisp-mode)
      (eglot-ensure)))

  (add-hook 'prog-mode-hook #'emacs/eglot-setup)


  ;; Define the LSP servers for each language
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs '((python-ts-mode . ("pyright-langserver" "--stdio"))
                                          ((typescript-ts-mode tsx-ts-mode) . ("typescript-language-server" "--stdio"))
                                          (ruby-mode ruby-ts-mode) "ruby-lsp")))

  :bind (:map
         eglot-mode-map
         ("C-c l a" . eglot-code-actions)
         ("C-c l o" . eglot-code-actions-organize-imports)
         ("C-c l r" . eglot-rename)
         ("C-c l f" . eglot-format)))

;;; FLYMAKE
(use-package flymake
  :ensure nil
  :defer t
  :hook (prog-mode . flymake-mode)
  :bind (:map flymake-mode-map
              ("M-8" . flymake-goto-next-error)
              ("M-7" . flymake-goto-prev-error)
              ("C-c ! n" . flymake-goto-next-error)
              ("C-c ! p" . flymake-goto-prev-error)
              ("C-c ! l" . flymake-show-buffer-diagnostics)
              ("C-c ! t" . toggle-flymake-diagnostics-at-eol))
  :custom
  (flymake-show-diagnostics-at-end-of-line nil)
  ;; (flymake-show-diagnostics-at-end-of-line 'short)
  (flymake-indicator-type 'margins)
  (flymake-margin-indicators-string
   `((error "!" compilation-error)      ;; Alternatives: », E, W, i, !, ?)
     (warning "?" compilation-warning)
     (note "i" compilation-info)))
  :config
  ;; Define the toggle function
  (defun toggle-flymake-diagnostics-at-eol ()
    "Toggle the display of Flymake diagnostics at the end of the line
and restart Flymake to apply the changes."
    (interactive)
    (setq flymake-show-diagnostics-at-end-of-line
          (not flymake-show-diagnostics-at-end-of-line))
    (flymake-mode -1) ;; Disable Flymake
    (flymake-mode 1)  ;; Re-enable Flymake
    (message "Flymake diagnostics at end of line: %s"
             (if flymake-show-diagnostics-at-end-of-line
                 "Enabled" "Disabled"))))


;;; WHITESPACE
(use-package whitespace
  :ensure nil
  :defer t
  :hook (before-save . whitespace-cleanup)
  ;; if we wanna remove this hook at any time, eval:
  ;; (remove-hook 'before-save-hook #'whitespace-cleanup)
  )




;;; MAN
(use-package man
  :ensure nil
  :commands (man)
  :config
  (setq Man-notify-method 'pushy)) ; does not obey `display-buffer-alist'


;;; MINIBUFFER
(use-package minibuffer
  :ensure nil
  :custom
  (completion-styles '(partial-completion flex initials))
  (completions-format 'vertical)
  (completion-ignore-case t)
  (completion-show-help t)
  (completion-auto-select t) ;; only turn this on if not using icomplete
  (enable-recursive-minibuffers t)
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  :config
  ;; Keep the cursor out of the read-only portions of the.minibuffer
  (setq minibuffer-prompt-properties
        '(read-only t intangible t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Keep minibuffer lines unwrapped, long lines like on M-y will be truncated
  (add-hook 'minibuffer-setup-hook
          (lambda () (setq truncate-lines t)))

  (minibuffer-depth-indicate-mode 1)
  (minibuffer-electric-default-mode 1))


;;; NEWSTICKER
(use-package newsticker
  :ensure nil
  :defer t
  :custom
  (newsticker-treeview-treewindow-width 40)
  :hook
  (newsticker-treeview-item-mode . (lambda ()
                                     (define-key newsticker-treeview-item-mode-map
                                                 (kbd "V")
                                                 'emacs/newsticker-play-yt-video-from-buffer)))
  :init
  (defun emacs/newsticker-play-yt-video-from-buffer ()
    "Plays with mpv async, the current buffer found '* videoId: '."
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward "^\\* videoId: \\(\\w+\\)" nil t)
        (let ((video-id (match-string 1)))
          (start-process "mpv-video" nil "mpv" (format "https://www.youtube.com/watch?v=%s" video-id))
          (message "Playing with mpv: %s" video-id))))))


;;; ELEC_PAIR
(use-package elec-pair
  :ensure nil
  :defer
  :hook (after-init . electric-pair-mode))

;;; PAREN
(use-package paren
  :ensure nil
  :hook (after-init . show-paren-mode)
  :custom
  (show-paren-style 'mixed)
  (show-paren-context-when-offscreen t)) ;; show matches within window splits

;;; PROCED
(use-package proced
  :ensure nil
  :defer t
  :custom
  (proced-enable-color-flag t)
  (proced-tree-flag t)
  (proced-auto-update-flag 'visible)
  (proced-auto-update-interval 1)
  (proced-descent t)
  (proced-filter 'user) ;; We can change interactively with `s'
  :config
  (add-hook 'proced-mode-hook
            (lambda ()
              (proced-toggle-auto-update 1))))

;;; ORG
(use-package org
  :ensure nil
  :defer t
  :mode ("\\.org\\'" . org-mode)
  :config
  (setq
   ;; Start collapsed for speed
   org-startup-folded 'fold

   ;; Edit settings
   org-auto-align-tags nil
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t

   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers t
   ;; org-pretty-entities t

   ;; Agenda styling
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "◀── now ─────────────────────────────────────────────────")

  ;; Ellipsis styling
  (setq org-ellipsis " ▼ ")

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

  (set-face-attribute 'org-ellipsis nil :inherit 'default :box nil))


;;; TIME
(use-package time
  :ensure nil
  ;; :hook (after-init . display-time-mode) ;; If we'd like to see it on the modeline
  :custom
  (world-clock-time-format "%A %d %B %r %Z")
  (display-time-day-and-date t)
  (display-time-default-load-average nil)
  (display-time-mail-string "")
  (zoneinfo-style-world-list                ; use `M-x worldclock RET' to see it
   '(("America/Los_Angeles" "Los Angeles")
     ("America/New_York" "New York")
     ("America/Sao_Paulo" "São Paulo")
     ("UTC" "UTC"))))


;;; UNIQUIFY
(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-strip-common-suffix t)
  (setq uniquify-after-kill-buffer-p t))

;;; WHICH-KEY
(use-package which-key
  :defer t
  :ensure nil
  :hook
  (after-init . which-key-mode)
  :config
  (setq which-key-separator "  ")
  (setq which-key-prefix-prefix "... ")
  (setq which-key-max-display-columns 3)
  (setq which-key-idle-delay 1.5)
  (setq which-key-idle-secondary-delay 0.25)
  (setq which-key-add-column-padding 1)
  (setq which-key-max-description-length 40))


;;; THEMES
(use-package modus-themes
  :ensure nil
  :defer t
  :custom
  (modus-themes-italic-constructs t)
  (modus-themes-bold-constructs t)
  (modus-themes-mixed-fonts nil)
  (modus-themes-prompts '(bold intense))
  (modus-themes-common-palette-overrides
   `((bg-main "#292D3E")
     (bg-active bg-main)
     (fg-main "#EEFFFF")
     (fg-active fg-main)
     (fg-mode-line-active "#A6Accd")
     (bg-mode-line-active "#232635")
     (fg-mode-line-inactive "#676E95")
     (bg-mode-line-inactive "#282c3d")
     ;; (border-mode-line-active "#676E95")
     ;; (border-mode-line-inactive bg-dim)
     (border-mode-line-active nil)
     (border-mode-line-inactive nil)
     (bg-tab-bar      "#242837")
     (bg-tab-current  bg-main)
     (bg-tab-other    "#242837")
     (fg-prompt "#c792ea")
     (bg-prompt unspecified)
     (bg-hover-secondary "#676E95")
     (bg-completion "#2f447f")
     (fg-completion white)
     (bg-region "#3C435E")
     (fg-region white)

     (fg-line-number-active fg-main)
     (fg-line-number-inactive "gray50")
     (bg-line-number-active unspecified)
     (bg-line-number-inactive "#292D3E")
     (fringe "#292D3E")

     (fg-heading-0 "#82aaff")
     (fg-heading-1 "#82aaff")
     (fg-heading-2 "#c792ea")
     (fg-heading-3 "#bb80b3")
     (fg-heading-4 "#a1bfff")

     (fg-prose-verbatim "#c3e88d")
     (bg-prose-block-contents "#232635")
     (fg-prose-block-delimiter "#676E95")
     (bg-prose-block-delimiter bg-prose-block-contents)

     (accent-1 "#79a8ff")

     (keyword "#89DDFF")
     (builtin "#82aaff")
     (comment "#676E95")
     (string "#c3e88d")
     (fnname "#82aaff")
     (type "#c792ea")
     (variable "#c792ea")
     (docstring "#8d92af")
     (constant "#f78c6c")))
  :config
  (modus-themes-with-colors
    (custom-set-faces
     `(tab-bar
       ((,c
         :background "#232635"
         :foreground "#A6Accd"
         ;; :box (:line-width 1 :color "#676E95")
         )))
     `(tab-bar-tab
       ((,c
         ;; :background "#232635"
         ;; :underline t
         ;; :box (:line-width 1 :color "#676E95")
         )))
     `(tab-bar-tab-inactive
       ((,c
         ;; :background "#232635"
         ;; :box (:line-width 1 :color "#676E95")
         )))))
  :init
  (load-theme 'modus-vivendi t))

;;; TREESITTER
(setq treesit-language-source-alist
      '((cpp "https://github.com/tree-sitter/tree-sitter-cpp")
        (c "https://github.com/tree-sitter/tree-sitter-c")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (node "https://github.com/tree-sitter/node-tree-sitter")
        (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
        (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
        (bash "https://github.com/tree-sitter/tree-sitter-bash")))


;;; ------------------- EMACS-SOLO CUSTOMS
;;; EMACS-SOLO-HOOKS
;;
(use-package emacs-solo-hooks
  :ensure nil
  :no-require t
  :defer t
  :init

  (defun emacs/prefer-tabs ()
    "Disables indent-tabs-mode, and prefer spaces over tabs."
    (interactive)
    (indent-tabs-mode -1))

  (add-hook 'prog-mode-hook #'emacs/prefer-tabs))


;;; EMACS-SOLO-MODE-LINE
;;
;;  Customizations to the mode-line
;;
(use-package emacs-solo-mode-line
  :ensure nil
  :no-require t
  :defer t
  :init
  ;; Shorten big branches names
  (defun emacs/shorten-vc-mode (vc)
    "Shorten VC string to at most 20 characters.
 Replacing `Git-' with a branch symbol."
    (let* ((vc (replace-regexp-in-string "^ Git[:-]" "  " vc))) ;; Options:   ᚠ ⎇
      (if (> (length vc) 20)
          (concat (substring vc 0 20) "…")
        vc)))

  ;; Formats Modeline
  (setq-default mode-line-format
                '("%e" "  "
                  ;; (:propertize " " display (raise +0.1)) ;; Top padding
                  ;; (:propertize " " display (raise -0.1)) ;; Bottom padding
                  (:propertize "λ  " face font-lock-keyword-face)

                  (:propertize
                   ("" mode-line-mule-info mode-line-client mode-line-modified mode-line-remote))

                  mode-line-frame-identification
                  mode-line-buffer-identification
                  "   "
                  mode-line-position
                  mode-line-format-right-align
                  "  "
                  (project-mode-line project-mode-line-format)
                  "  "
                  (vc-mode (:eval (emacs/shorten-vc-mode vc-mode)))
                  "  "
                  mode-line-modes
                  mode-line-misc-info
                  "  ")
                project-mode-line t
                mode-line-buffer-identification '(" %b")
                mode-line-position-column-line-format '(" %l:%c"))

  ;; Provides the Diminish functionality
  (defvar emacs-solo-hidden-minor-modes
    '(abbrev-mode
      eldoc-mode
      flyspell-mode
      smooth-scroll-mode
      outline-minor-mode
      which-key-mode))

  (defun emacs/purge-minor-modes ()
    (interactive)
    (dolist (x emacs-solo-hidden-minor-modes nil)
      (let ((trg (cdr (assoc x minor-mode-alist))))
        (when trg
          (setcar trg "")))))

  (add-hook 'after-change-major-mode-hook 'emacs/purge-minor-modes))

;;; EMACS-SOLO-EXEC-PATH-FROM-SHELL
;;
;;  Loads users default shell PATH settings into Emacs. Usefull
;;  when calling Emacs directly from GUI systems.
;;
(use-package emacs-solo-exec-path-from-shell
  :ensure nil
  :no-require t
  :defer t
  :init
  (defun emacs/set-exec-path-from-shell-PATH ()
    "Set up Emacs' `exec-path' and PATH environment the same as user Shell."
    (interactive)
    (let ((path-from-shell
           (replace-regexp-in-string
            "[ \t\n]*$" "" (shell-command-to-string
                            "$SHELL --login -c 'echo $PATH'"))))
      (setenv "PATH" path-from-shell)
      (setq exec-path (split-string path-from-shell path-separator))
      (message ">>> emacs: PATH loaded")))

  (defun emacs/fix-asdf-path ()
  "Ensure asdf shims and active Node.js version's bin directory are first in PATH."
  (interactive)
  (let* ((asdf-shims (expand-file-name "~/.asdf/shims"))
         (node-bin (string-trim (shell-command-to-string "asdf where nodejs 2>/dev/null")))
         (new-paths (list asdf-shims)))

    ;; If Node.js is installed, add its bin path
    (when (file-directory-p node-bin)
      (push (concat node-bin "/bin") new-paths))

    ;; Remove old asdf-related paths from PATH and exec-path
    (setq exec-path (seq-remove (lambda (p) (string-match-p "/\\.asdf/" p)) exec-path))
    (setenv "PATH" (string-join (seq-remove (lambda (p) (string-match-p "/\\.asdf/" p))
                                            (split-string (getenv "PATH") ":"))
                                ":"))

    ;; Add the new paths to exec-path and PATH
    (dolist (p (reverse new-paths))
      (unless (member p exec-path) (push p exec-path))
      (unless (member p (split-string (getenv "PATH") ":"))
        (setenv "PATH" (concat p ":" (getenv "PATH")))))))

  (add-hook 'find-file-hook #'emacs/fix-asdf-path)
  (add-hook 'eshell-mode-hook #'emacs/fix-asdf-path)
  (add-hook 'eshell-pre-command-hook #'emacs/fix-asdf-path)
  (add-hook 'eshell-directory-change-hook #'emacs/fix-asdf-path)

  (add-hook 'after-init-hook #'emacs/set-exec-path-from-shell-PATH)
  (add-hook 'after-init-hook #'emacs/fix-asdf-path))


(add-to-list 'load-path (concat user-emacs-directory "/elisp"))

(require 'init-evil)
(require 'init-themes)
(require 'init-completion)
(require 'init-development)

(provide 'init)
;;; init.el ends here
