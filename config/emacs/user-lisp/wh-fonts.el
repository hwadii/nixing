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
      :default-weight regular
      :default-width normal
      :fixed-pitch-family "Source Code Pro"
      :fixed-pitch-weight regular
      :variable-pitch-family "Work Sans"
      :variable-pitch-height 150))))

(set-fontset-font t nil "DejaVu Sans Mono" nil 'append)
(set-fontset-font t nil "Font Awesome 7 Free" nil 'append)
(set-fontset-font t nil "Symbols Nerd Font" nil 'append)

(provide 'wh-fonts)
;;; wh-fonts.el ends here
