;;; wh-eshell-prompt.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'modus-themes)

(defun wh-pwd-replace-home (pwd)
  "Replace home in PWD with tilde (~) character."
  (let* ((home (expand-file-name (getenv "HOME")))
         (home-len (length home)))
    (if (and
         (>= (length pwd) home-len)
         (equal home (substring pwd 0 home-len)))
        (concat "~" (substring pwd home-len))
      pwd)))

(defun wh-pwd-shorten-dirs (pwd n)
  "Shorten all directory names in PWD except the last N."
  (let ((p-lst (split-string pwd "/")))
    (if (> (length p-lst) n)
        (concat
         (mapconcat (lambda (elm) (if (zerop (length elm)) ""
                                    (substring elm 0 1)))
                    (butlast p-lst n)
                    "/")
         "/"
         (mapconcat (lambda (elm) elm)
                    (last p-lst n)
                    "/"))
      pwd)))

;;;###autoload
(defun wh-eshell-prompt-fn ()
  "Eshell prompt with colors from the current (modus-themes based) enabled theme."
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

(provide 'wh-eshell-prompt)

;;; wh-eshell-prompt.el ends here
