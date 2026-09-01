;;; wh-eshell-prompt.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;;;###autoload
(defun wh-pwd-replace-home (pwd)
  "Replace home in PWD with tilde (~) character."
  (let* ((home (expand-file-name (getenv "HOME")))
         (home-len (length home)))
    (if (and
         (>= (length pwd) home-len)
         (equal home (substring pwd 0 home-len)))
        (concat "~" (substring pwd home-len))
      pwd)))

;;;###autoload
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

(provide 'wh-eshell-prompt)

;;; wh-eshell-prompt.el ends here
