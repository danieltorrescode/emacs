;;; init-splash.el --- Simple splash screen with image -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(defvar my-splash-image-path "~/Documents/Wallpapers/banners/emacs-2.png"
  "Path to the image displayed on the splash screen.")
(defvar my-splash-buffer-name "*splash*"
  "Name of the splash screen buffer.")
(defvar my-splash-image-width 600
  "Desired image width in pixels. nil for original size.")
(defvar my-splash-image-height nil
  "Desired image height in pixels. nil to preserve aspect ratio.")
(defvar my-splash-vertical-position 0.25
  "Vertical position of the image. 0.0 = top, 0.5 = center, 1.0 = bottom.")
(defvar my-splash-horizontal-position 0.5
  "Horizontal position of the image. 0.0 = left, 0.5 = center, 1.0 = right.")
(defun my-splash-center-image (&optional image-path
                                         width height
                                         vertical-pos horizontal-pos)
  "Insert an image into the buffer with configurable position and size.
IMAGE-PATH: path to the image (default: my-splash-image-path)
WIDTH:       width in pixels (default: my-splash-image-width)
HEIGHT:      height in pixels (default: my-splash-image-height)
VERTICAL-POS:   0.0 top -> 1.0 bottom  (default: my-splash-vertical-position)
HORIZONTAL-POS: 0.0 left -> 1.0 right  (default: my-splash-horizontal-position)"
  (let* (;; Parameters with fallback to global variables
         (path     (or image-path       my-splash-image-path))
         (w        (or width            my-splash-image-width))
         (h        (or height           my-splash-image-height))
         (vpos     (or vertical-pos     my-splash-vertical-position))
         (hpos     (or horizontal-pos   my-splash-horizontal-position))
         ;; Build scale parameters for create-image
         (scale-props (cond
                       ((and w h) `(:width ,w :height ,h))
                       (w         `(:width ,w))
                       (h         `(:height ,h))
                       (t         '())))
         ;; Create image with or without scaling
         (image (apply #'create-image path nil nil scale-props))
         ;; Actual image size (after scaling)
         (image-size   (image-size image t))
         (image-width  (car image-size))
         (image-height (cdr image-size))
         ;; Frame dimensions
         (win-pixel-width  (window-pixel-width))
         (win-body-height  (window-body-height))  ;; in lines
         (char-width       (frame-char-width))
         (char-height      (frame-char-height))
         ;; Image height in lines (approximate)
         (image-lines (ceiling (/ (float image-height) char-height)))
         ;; Margin calculations
         (margin-pixels (max 0 (round (* hpos (- win-pixel-width image-width)))))
         (margin-chars  (max 0 (/ margin-pixels char-width)))
         (lines-top     (max 0 (round (* vpos (- win-body-height image-lines))))))
    ;; Insert vertical spacing
    (dotimes (_ lines-top)
      (insert "\n"))
    ;; Insert horizontal margin + image
    (insert (make-string margin-chars ?\s))
    (insert-image image)
    (insert "\n")))
(defvar my-splash--previous-alpha nil)
(defvar my-splash--close-advice-added nil)
(defun my-splash--close-on-switch (&rest _)
  "Close the splash screen when the user switches buffers."
  (when (get-buffer my-splash-buffer-name)
    (my-splash-close)
    ;; Remove itself after executing once
    (advice-remove 'switch-to-buffer #'my-splash--close-on-switch)
    (advice-remove 'pop-to-buffer    #'my-splash--close-on-switch)
    (advice-remove 'consult-buffer   #'my-splash--close-on-switch)
    (setq my-splash--close-advice-added nil)))
(defun my-splash-add-close-advice ()
  "Register advice to close the splash screen when switching buffers."
  (unless my-splash--close-advice-added
    (advice-add 'switch-to-buffer :before #'my-splash--close-on-switch)
    (advice-add 'pop-to-buffer    :before #'my-splash--close-on-switch)
    (setq my-splash--close-advice-added t)))
(defun my-splash-open ()
  (interactive)
  (let ((buf (get-buffer-create my-splash-buffer-name)))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (setq cursor-type nil)
        (buffer-disable-undo)
        (my-splash-center-image)
        (goto-char (point-min))
        (read-only-mode 1)
        ;; (local-set-key [t] #'my-splash-close)
        ;; (local-set-key (kbd "q") #'my-splash-close)
        ;; Transparent background -> inherits from frame
        (toggle-transparency)
        (setq-local face-remapping-alist
                    '((default :background "unspecified-bg")
                      (fringe  :background "unspecified-bg")))
        ;; (setq-local mode-line-format nil)
        (setq-local header-line-format nil)))
    (switch-to-buffer buf)
    (my-splash-add-close-advice)))
(defun my-splash-close ()
  (interactive)
  (let ((buf (get-buffer my-splash-buffer-name)))
    (when buf
      (toggle-transparency)
      ;; Remove all registered advices
      (advice-remove 'switch-to-buffer #'my-splash--close-on-switch)
      (advice-remove 'pop-to-buffer    #'my-splash--close-on-switch)
      (advice-remove 'consult-buffer   #'my-splash--close-on-switch)
      (setq my-splash--close-advice-added nil)
      ;; Restore previous alpha value
      (set-frame-parameter nil 'alpha (or my-splash--previous-alpha 100))
      ;; Hide the buffer first without killing it
      (bury-buffer buf)
      ;; Kill in the next cycle once consult has finished
      ;; (run-with-timer 0 nil
      ;;                 (lambda ()
      ;;                   (when (buffer-live-p buf)
      ;;                     (kill-buffer buf))))
      )))
;; Disable Emacs default splash screen
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-buffer-choice nil)
(defun my-splash-startup ()
  "Launch the splash screen on startup (graphical mode only)."
  (when (display-graphic-p)
    (my-splash-open)
    ;; (consult-recent-file)
    ;; Wait before opening recentf after splash is visible
    ;; (run-with-timer 5.0 nil #'consult-recent-file)
    ))
(global-set-key (kbd "M-d") 'my-splash-open)
(add-hook 'emacs-startup-hook #'my-splash-startup)

(provide 'init-splash)

;;; init-splash.el ends here
