;;; wh-org.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(defun wh-org-currency-to-number (s)
  "Transforms S (a currency value) to a plain number."
  (string-to-number (replace-regexp-in-string "[^0-9.-]" "" s)))

(provide 'wh-org)

;;; wh-org.el ends here
