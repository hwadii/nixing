;;; wh-tenderbolt.el --- -*- lexical-binding: t -*-

;;; Commentary: Extensions for interacting with Tenderbolt tools

;;; Code:

(require 'project)

(use-package sql
  :ensure nil
  :config
  (add-to-list 'sql-connection-alist '("tenderbolt-dev"
                                       (sql-product 'postgres)
                                       (sql-server "127.0.0.1")
                                       (sql-port 54322)
                                       (sql-user "postgres")
                                       (sql-password "postgres")
                                       (sql-database "postgres")))
  (add-to-list 'sql-connection-alist '("tenderbolt-test"
                                       (sql-product 'postgres)
                                       (sql-server "127.0.0.1")
                                       (sql-port 5432)
                                       (sql-user "postgres")
                                       (sql-password "postgres")
                                       (sql-database "postgres"))))
(use-package mise
  :commands (global-mise-mode mise-update-dir)
  :ensure t
  :config (global-mise-mode))
(use-package magit
  :config
  (add-to-list 'magit-repository-directories '("~/dev/tenderbolt" . 1)))

(defun tenderbolt-compile-frontend ()
  "Compile the Tenderbolt frontend with the correct `default-directory'."
  (interactive)
  (let ((default-directory (file-name-concat (project-root (project-current t)) "frontend")))
    (compile "mise run compile")))

(defun tenderbolt-run-frontend ()
  "Run the Tenderbolt frontend using pitchfork."
  (interactive)
  (async-shell-command "pitchfork start -f ui"))

(defvar-keymap tenderbolt-command-map
  :doc "Tenderbolt commands."
  "c" #'tenderbolt-compile-frontend
  "r" #'tenderbolt-run-frontend)

(defvar-keymap tenderbolt-mode-map
  :doc "Keymap for `tenderbolt-mode'."
  "C-c t" tenderbolt-command-map)

(define-minor-mode tenderbolt-mode
  "Tenderbolt minor mode."
  :lighter "Tenderbolt"
  :keymap tenderbolt-mode-map)

(provide 'wh-tenderbolt)

;;; wh-tenderbolt.el ends here
