;;; wh-eshell.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'magit)

(defun wh-eshell-modus-prompt-function ()
  "Eshell prompt with colors from the current (modus-themes based) enabled theme."
  (require 'modus-themes)
  (modus-themes-with-colors
    (let ((cwd (wh-pwd-shorten-dirs (wh-pwd-replace-home (eshell/pwd)) 1))
          (branch (magit-get-current-branch))
          (stat (magit-file-status))
          (suffix (if (= (file-user-uid) 0) "#" ">"))
          (nix-shell? (getenv "IN_NIX_SHELL")))
      (format "%s%s%s%s "
              (if nix-shell?
                  (propertize "<nix> " 'face `(:foreground ,cyan))
                "")
              (propertize cwd 'face `(:weight bold :foreground ,blue-warmer))
              (if branch
                  (format "%s%s%s"
                          (propertize "❙" 'face `(:foreground ,blue))
                          (propertize (format "%s" branch) 'face `(:foreground ,blue))
                          (propertize (if (length> stat 0) "*" "") 'face `(:weight bold :foreground ,yellow)))
                "")
              (if (eshell-exit-success-p)
                  (propertize suffix 'face `(:weight bold :foreground ,yellow))
                (propertize suffix 'face `(:weight bold :foreground ,red-cooler)))))))

(defun wh-eshell-modus-prompt-hook ()
  "Hook to set `eshell-prompt-function' to `wh-eshell-modus-prompt-function'."
  (customize-set-variable 'eshell-prompt-function #'wh-eshell-modus-prompt-function))

(defun wh-eshell-doric-prompt-function ()
  "Eshell prompt with colors from the current (doric-themes based) enabled theme."
  (require 'doric-themes)
  (doric-themes-with-colors
    (let ((cwd (wh-pwd-shorten-dirs (wh-pwd-replace-home (eshell/pwd)) 1))
          (branch (magit-get-current-branch))
          (stat (magit-file-status))
          (suffix (if (= (file-user-uid) 0) "#" ">"))
          (nix-shell? (getenv "IN_NIX_SHELL")))
      (format "%s%s%s%s "
              (if nix-shell?
                  (propertize "<nix> " 'face `(:foreground ,fg-cyan))
                "")
              (propertize cwd 'face `(:weight bold :foreground ,fg-shadow-subtle))
              (if branch
                  (format "%s%s%s"
                          (propertize "❙" 'face `(:foreground ,fg-cyan))
                          (propertize (format "%s" branch) 'face `(:foreground ,fg-cyan))
                          (propertize (if (length> stat 0) "*" "") 'face `(:weight bold :foreground ,fg-yellow)))
                "")
              (if (eshell-exit-success-p)
                  (propertize suffix 'face `(:weight bold :foreground ,fg-yellow))
                (propertize suffix 'face `(:weight bold :foreground ,fg-red)))))))

(defun wh-eshell-doric-prompt-hook ()
  "Hook to set `eshell-prompt-function' to `wh-eshell-doric-prompt-function'."
  (customize-set-variable 'eshell-prompt-function #'wh-eshell-doric-prompt-function))

(provide 'wh-eshell)

;;; wh-eshell.el ends here
