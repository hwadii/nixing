;;; wh-fonts.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package fontaine
  :ensure t
  :init (fontaine-mode 1)
  :config (fontaine-set-preset 'classic)
  :bind (:map wh-map ("f" . fontaine-set-preset))
  :custom
  (fontaine-presets
   '((regular
      :default-family "JetBrains Mono NL"
      :default-height 160
      :default-weight regular
      :fixed-pitch-family "JetBrains Mono NL"
      :variable-pitch-family "Lexend"
      :variable-pitch-height 160
      :variable-pitch-weight regular
      :bold-weight bold)
     (regular-home
      :inherit regular
      :default-height 190
      :default-weight regular
      :variable-pitch-height 190)
     (classic
      :default-family "Source Code Pro"
      :default-height 170
      :default-weight regular
      :fixed-pitch-family "Source Code Pro"
      :fixed-pitch-weight regular
      :variable-pitch-family "Schibsted Grotesk"
      :variable-pitch-height 160
      :variable-pitch-weight regular)
     (classic-home
      :inherit classic
      :default-height 190
      :variable-pitch-height 180))))

(set-fontset-font t nil "Font Awesome 7 Free" nil 'append)

(provide 'wh-fonts)
;;; wh-fonts.el ends here
