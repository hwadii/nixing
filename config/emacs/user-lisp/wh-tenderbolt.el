;;; wh-tenderbolt.el --- -*- lexical-binding: t -*-

;;; Commentary: Extensions for interacting with Tenderbolt tools

;;; Code:

(require 'project)
(require 'ghostel)

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
  (let* ((root (project-root (project-current t)))
        (default-directory (file-name-concat root "frontend")))
    (compile "mise run compile")))

(defun tenderbolt-test-frontend ()
  "Test the Tenderbolt frontend with the correct `default-directory'."
  (interactive)
  (let* ((root (project-root (project-current t)))
        (default-directory (file-name-concat root "frontend")))
    (compile "yarn test")))

(defun tenderbolt-run-frontend ()
  "Run the Tenderbolt frontend using pitchfork."
  (interactive)
  (async-shell-command "pitchfork start -f ui"))

(defun tenderbolt-run-robot (&optional arg)
  "Run a robot session within Tenderbolt.
Pop to the existing session if there is one, otherwise create one.
If ARG is passed, create a new buffer."
  (interactive "P")
  (let* ((proj (project-current t))
         (default-directory (project-root proj))
         (name "*claude: tenderbolt*")
         (existing (get-buffer name)))
    (if (and existing (not arg))
        (pop-to-buffer-same-window existing)
      (let ((buf (generate-new-buffer name)))
        (ghostel-exec buf "claude")
        (pop-to-buffer-same-window buf)))))

(defvar-keymap tenderbolt-command-map
  :doc "Tenderbolt commands."
  "c" #'tenderbolt-compile-frontend
  "r" #'tenderbolt-run-frontend
  "b" #'tenderbolt-run-robot)

(defvar-keymap tenderbolt-mode-map
  :doc "Keymap for `tenderbolt-mode'."
  "C-c t" tenderbolt-command-map)

(define-minor-mode tenderbolt-mode
  "Tenderbolt minor mode."
  :lighter "Tenderbolt"
  :keymap tenderbolt-mode-map)

(provide 'wh-tenderbolt)

;;; wh-tenderbolt.el ends here
