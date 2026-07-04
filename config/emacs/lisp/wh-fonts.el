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
      :default-family "JetBrains Mono NL"
      :default-height 160
      :default-weight regular
      :fixed-pitch-family "JetBrains Mono NL"
      :fixed-pitch-weight regular
      :variable-pitch-family "IBM Plex Sans Condensed"
      :variable-pitch-height 160
      :variable-pitch-weight regular)
     (regular-macos
      :inherit regular
      :default-weight semi-light
      :fixed-pitch-weight semi-light))))

(set-fontset-font t nil "Font Awesome 7 Free" nil 'append)
(set-fontset-font t nil "Symbols Nerd Font" nil 'append)

(provide 'wh-fonts)
;;; wh-fonts.el ends here
