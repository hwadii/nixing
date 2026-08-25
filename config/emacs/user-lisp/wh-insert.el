;;; wh-insert.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'org-macs)

;;;###autoload
(defun wh-insert-date (&optional arg)
  "Insert a date.
If ARG is passed, then insert a date without dashes."
  (interactive "P")
  (insert (if arg
              (format-time-string "%Y%m%d")
            (format-time-string "%F"))))

;;;###autoload
(defun wh-insert-time ()
  "Insert a timestamp."
  (interactive)
  (insert (format-time-string "%FT%T%z")))

;;;###autoload
(defun wh-insert-uuid ()
  "Insert a uuidv4."
  (interactive)
  (insert (org-id-uuid)))

(provide 'wh-insert)

;;; wh-insert.el ends here
