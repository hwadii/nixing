;;; wh-fonts.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package fontaine
  :ensure t
  :init (fontaine-mode 1)
  :config (fontaine-set-preset 'regular)
  :custom
  (fontaine-presets
   '((regular
      :default-family "Berkeley Mono Variable"
      :default-height 160
      :default-weight regular
      :fixed-pitch-family "Berkeley Mono Variable"
      :fixed-pitch-weight regular
      :variable-pitch-family "Lexend"
      :variable-pitch-height 150
      :variable-pitch-weight regular
      :bold-weight bold)
     (classic
      :default-family "Source Code Pro"
      :default-height 160
      :default-weight medium
      :fixed-pitch-family "Source Code Pro"
      :fixed-pitch-weight medium
      :variable-pitch-family "Lexend"
      :variable-pitch-height 150
      :variable-pitch-weight regular
      :bold-weight bold))))

(set-fontset-font t nil "Font Awesome 7 Free" nil 'append)

(provide 'wh-fonts)
;;; wh-fonts.el ends here
