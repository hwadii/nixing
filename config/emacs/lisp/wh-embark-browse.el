;;; wh-embark-browse.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'embark)
(require 'wh-browse)

(defvar-keymap wh-embark-browse-map
  :doc "Keymap for Web search commands"
  :parent nil
  "d" #'browse-ddg
  "s" #'ddgr-search)

(fset 'wh-embark-browse-map wh-embark-browse-map)
(keymap-set embark-general-map "S" 'wh-embark-browse-map)

(provide 'wh-embark-browse)

;;; wh-embark-browse.el ends here
