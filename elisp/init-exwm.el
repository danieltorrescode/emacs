;;; init-exwm.el --- Summary
;;; Commentary:
;;; Code:

;; Also shrink fringes to 1 pixel.
;; (fringe-mode 1)

;; Turn on `display-time-mode' if you don't use an external bar.
(setq display-time-default-load-average nil)
(display-time-mode t)

;; You are strongly encouraged to enable something like `ido-mode' to alter
;; the default behavior of 'C-x b', or you will take great pains to switch
;; to or back from a floating frame (remember 'C-x 5 o' if you refuse this
;; proposal however).
;; You may also want to call `exwm-config-ido' later (see below).
;; (ido-mode 1)

;; Emacs server is not required to run EXWM but it has some interesting uses
;; (see next section).
;; (server-start)

;;;; Below are configurations for EXWM.

;; Add paths (not required if EXWM is installed from GNU ELPA).
;(add-to-list 'load-path "/path/to/xelb/")
;(add-to-list 'load-path "/path/to/exwm/")

(defun run-firefox ()
  "Start Firefox."
  (interactive)
  (start-process "Firefox" nil "~/firefox/firefox"))

(defun run-st ()
  "Start Simple Terminal."
  (interactive)
  (start-process "ST" nil "st"))

;; This is an example `use-package' configuration
;; It is not tangled into wallpaper.el
(use-package wallpaper
  :ensure t
  :hook ((exwm-randr-screen-change . wallpaper-set-wallpaper)))

(defgroup wallpaper nil
  "Setting the wallpaper."
  :tag "Wallpaper"
  :group 'environment
  :prefix "wallpaper-")

(defcustom wallpaper-static-wallpaper-list nil
  "List of wallpapers to use instead of randomly finding wallpapers.
  Wallpapers must be entered in this list as absolute paths, in the order
  of your monitors.  This list should be left blank if you intend to use
  function `wallpaper-cycle-mode'."
  :tag "Static wallpaper(s)"
  :group 'wallpaper
  :type 'list)

;; This is an example, not tangled into wallpaper.el
(setq wallpaper-static-wallpapers '~/.config/wallpaper.png)


;; Set the initial number of workspaces (they can also be created later).
(setq exwm-workspace-number 4)

;; All buffers created in EXWM mode are named "*EXWM*". You may want to
;; change it in `exwm-update-class-hook' and `exwm-update-title-hook', which
;; are run when a new X window class name or title is available.  Here's
;; some advice on this topic:
;; + Always use `exwm-workspace-rename-buffer` to avoid naming conflict.
;; + For applications with multiple windows (e.g. GIMP), the class names of
;    all windows are probably the same.  Using window titles for them makes
;;   more sense.
;; In the following example, we use class names for all windows except for
;; Java applications and GIMP.
(add-hook 'exwm-update-class-hook
          (lambda ()
            (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                        (string= "gimp" exwm-instance-name))
              (exwm-workspace-rename-buffer exwm-class-name))))
(add-hook 'exwm-update-title-hook
          (lambda ()
            (when (or (not exwm-instance-name)
                      (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                      (string= "gimp" exwm-instance-name))
              (exwm-workspace-rename-buffer exwm-title))))

;; Global keybindings can be defined with `exwm-input-global-keys'.
;; Here are a few examples:
(setq exwm-input-global-keys
      `(
        ;; Bind "s-r" to exit char-mode and fullscreen mode.
        ([?\s-r] . exwm-reset)
        ;; Bind "s-w" to switch workspace interactively.
        ([?\s-w] . exwm-workspace-switch)
        ;; Bind "s-0" to "s-9" to switch to a workspace by its index.
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))
        ;; Bind "s-&" to launch applications ('M-&' also works if the output
        ;; buffer does not bother you).
        ([?\s-&] . (lambda (command)
             (interactive (list (read-shell-command "$ ")))
             (start-process-shell-command command nil command)))
        ;; running others programs
        ([?\s-s]          . run-st)
        ([?\s-f]          . run-firefox)
        ;; Bind "s-<f2>" to "slock", a simple X display locker.
        ([s-f2] . (lambda ()
            (interactive)
            (start-process "" nil "/usr/bin/slock")))))

;; To add a key binding only available in line-mode, simply define it in
;; `exwm-mode-map'.  The following example shortens 'C-c q' to 'C-q'.
;; (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)


;; The following example demonstrates how to use simulation keys to mimic
;; the behavior of Emacs.  The value of `exwm-input-simulation-keys` is a
;; list of cons cells (SRC . DEST), where SRC is the key sequence you press
;; and DEST is what EXWM actually sends to application.  Note that both SRC
;; and DEST should be key sequences (vector or string).
(setq exwm-input-simulation-keys
      '(
        ;; movement
        ([?\C-b] . [left])
        ([?\M-b] . [C-left])
        ([?\C-f] . [right])
        ([?\M-f] . [C-right])
        ([?\C-p] . [up])
        ([?\C-n] . [down])
        ([?\C-a] . [home])
        ([?\C-e] . [end])
        ([?\M-v] . [prior])
        ([?\C-v] . [next])
        ([?\C-d] . [delete])
        ([?\C-k] . [S-end delete])
        ;; cut/paste.
        ([?\C-w] . [?\C-x])
        ([?\M-w] . [?\C-c])
        ([?\C-y] . [?\C-v])
        ;; search
        ([?\C-s] . [?\C-f])))

;; You can hide the minibuffer and echo area when they're not used, by
;; uncommenting the following line.
;(setq exwm-workspace-minibuffer-position 'bottom)

;; Do not forget to enable EXWM. It will start by itself when things are
;; ready.  You can put it _anywhere_ in your configuration.
(exwm-enable)

(provide 'init-exwm)

;;; init-exwm.el ends here
