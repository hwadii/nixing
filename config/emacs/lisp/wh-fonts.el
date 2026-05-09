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
      :variable-pitch-family "Atkinson Hyperlegible Next"
      :variable-pitch-height 160
      :variable-pitch-weight regular
      :bold-weight bold)
     (classic
      :default-family "Liberation Mono"
      :default-height 160
      :default-weight regular
      :fixed-pitch-family "Liberation Mono"
      :fixed-pitch-weight regular
      :variable-pitch-family "Atkinson Hyperlegible Next"
      :variable-pitch-height 150
      :variable-pitch-weight regular
      :bold-weight bold))))

(set-fontset-font t nil "Font Awesome 7 Free" nil 'append)

(provide 'wh-fonts)
;;; wh-fonts.el ends here
