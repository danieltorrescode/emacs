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

(provide 'init-wallpaper)