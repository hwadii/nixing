;;; wh-tenderbolt.el --- -*- lexical-binding: t -*-

;;; Commentary: Extensions for interacting with Tenderbolt tools

;;; Code:

(require 'project)
(require 's)
(require 'transient)

(declare-function ghostel-exec "ghostel")

;;;###autoload
(defun tenderbolt-compile-frontend ()
  "Compile the Tenderbolt frontend with the correct `default-directory'."
  (interactive)
  (let* ((root (project-root (project-current t)))
        (default-directory (file-name-concat root "frontend"))
        (compilation-buffer-name-function (lambda (_) "*tenderbolt: tsc*")))
    (compile "yarn typecheck")))

;;;###autoload
(defun tenderbolt-test-frontend (&optional arg)
  "Test the Tenderbolt frontend with the correct `default-directory'.
If ARG is given, then prompt with `completing-read' for a file."
  (interactive "P")
  (let* ((pr (project-current t))
         (root (project-root pr))
         (files (project-files pr))
         (default-directory (file-name-concat root "frontend"))
         (compilation-buffer-name-function (lambda (_) "*tenderbolt: vitest*")))
    (compile (if arg
                 (format "yarn test --run %s"
                         (shell-quote-argument
                          (file-relative-name
                           (funcall project-read-file-name-function "Select file to test" files nil 'file-name-history)
                           default-directory)))
               "yarn test"))))

;;;###autoload
(defun tenderbolt-run-frontend ()
  "Run the Tenderbolt frontend using pitchfork."
  (interactive)
  (async-shell-command "pitchfork start -f ui"))

;;;###autoload
(defun tenderbolt-run-robot (&optional arg)
  "Run a robot session within Tenderbolt.
Pop to the existing session if there is one, otherwise create one.
If ARG is passed, create a new buffer."
  (interactive "P")
  (let* ((proj (project-current t))
         (default-directory (project-root proj))
         (name "*robot: tenderbolt*")
         (existing (get-buffer name)))
    (if (and existing (not arg))
        (pop-to-buffer-same-window existing)
      (let ((buf (generate-new-buffer name)))
        (ghostel-exec buf "claude")
        (pop-to-buffer-same-window buf)))))

;;;###autoload
(defun tenderbolt-run-shell ()
  "Run a Django shell session within Tenderbolt.
If a session already exists, pop to its buffer."
  (interactive)
  (let* ((proj (project-current t))
         (default-directory (project-root proj))
         (name "*shell: tenderbolt*")
         (existing (get-buffer name)))
    (unless existing
      (let ((buf (get-buffer-create name)))
        (ghostel-exec buf "make" '("shell"))))
    (pop-to-buffer-same-window name)))

(defvar-keymap tenderbolt-command-map
  :doc "Tenderbolt commands."
  "c" #'tenderbolt-compile-frontend
  "r" #'tenderbolt-run-frontend
  "b" #'tenderbolt-run-robot
  "s" #'tenderbolt-run-shell
  "t" #'tenderbolt-test-frontend)

(defvar-keymap tenderbolt-mode-map
  :doc "Keymap for `tenderbolt-mode'."
  "C-c a" #'tenderbolt-menu)

;;;###autoload
(transient-define-prefix tenderbolt-menu ()
  ["General"
   ("b" "Run robot" tenderbolt-run-robot)]
  ["Backend"
   ("s" "Open a Django shell session" tenderbolt-run-shell)]
  ["Frontend"
   ("r" "Run" tenderbolt-run-frontend)
   ("t" "Run tests" tenderbolt-test-frontend)
   ("c" "Typecheck" tenderbolt-compile-frontend)])

;;;###autoload
(define-minor-mode tenderbolt-mode
  "Tenderbolt minor mode."
  :lighter "Tenderbolt"
  :keymap tenderbolt-mode-map)

(provide 'wh-tenderbolt)

;;; wh-tenderbolt.el ends here
