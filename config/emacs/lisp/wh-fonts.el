;;; wh-fonts.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package fontaine
  :ensure t
  :init (fontaine-mode 1)
  :config (fontaine-set-preset (or (fontaine-restore-latest-preset) 'regular))
  :bind (:map wh-map ("f" . fontaine-set-preset))
  :custom
  (fontaine-presets
   '((regular
      :default-family "Source Code Pro"
      :default-height 160
      :default-weight medium
      :fixed-pitch-family "Source Code Pro"
      :fixed-pitch-weight medium
      :variable-pitch-family "Source Sans Pro"
      :variable-pitch-height 160
      :variable-pitch-weight regular)
     (regular-macos
      :inherit regular
      :default-weight regular
      :fixed-pitch-weight regular))))

(set-fontset-font t nil "Font Awesome 7 Free" nil 'append)
(set-fontset-font t nil "Symbols Nerd Font" nil 'append)

(provide 'wh-fonts)
;;; wh-fonts.el ends here
