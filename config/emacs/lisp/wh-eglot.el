;;; wh-eglot.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package eglot
  :ensure t
  :custom
  (eglot-autoshutdown t)
  (eglot-sync-connect 3)
  (eglot-stay-out-of nil)
  (eglot-send-changes-idle-time 0.5)
  (eglot-events-buffer-config :size 0)
  (eglot-code-action-indications '(eldoc-hint))
  (eglot-ignored-server-capabilities '(:semanticTokensProvider))
  (eglot-workspace-configuration
   '((:javascript
      (:preferences
       (:importModuleSpecifierEnding "shortest")))
     (:typescript
      (:preferences
       (:importModuleSpecifierEnding "shortest")))))
  :bind
  ("C-c l c" . eglot-reconnect)
  ("C-c l l" . eglot)
  ("C-c l r" . eglot-rename)
  ("C-c l s" . eglot-shutdown)
  ("C-c l i" . eglot-inlay-hints-mode)
  ("C-c l a" . eglot-code-actions)
  ("C-c l m" . flymake-show-buffer-diagnostics)
  :config
  (add-to-list 'eglot-server-programs '((ruby-mode ruby-ts-mode) . ("ruby-lsp")))
  (add-to-list 'eglot-server-programs '(scala-ts-mode . ("metals")) t)
  (add-to-list 'eglot-server-programs '(zig-ts-mode . ("zls")) t)
  (add-to-list 'eglot-server-programs '(nix-ts-mode . ("nil")) t)
  (add-to-list 'eglot-server-programs '((tsx-mode tsx-ts-mode) . ("tailwindcss-language-server" "--stdio")) t)
  :hook
  (eglot-managed-mode . (lambda () (eglot-inlay-hints-mode -1))))

(use-package breadcrumb
  :ensure t
  :bind
  ("C-c l b" . breadcrumb-local-mode))

;;;###autoload
(defun wh-eglot-setup-deno ()
  "Setup deno lsp for eglot when editing typescript."
  (interactive)
  (add-to-list 'eglot-server-programs '((typescript-mode typescript-ts-mode) . (eglot-deno "deno" "lsp")))

  (defclass eglot-deno (eglot-lsp-server) ()
    :documentation "A custom class for deno lsp.")

  (cl-defmethod eglot-initialization-options ((server eglot-deno))
    "Passes through required deno initialization options"
    (list
     :enable t
     :enablePaths t
     :lint t)))

;;;###autoload
(defun wh-eglot-unset-deno ()
  "Unset deno lsp eglot setup. Use tsserver when editing typescript."
  (interactive)
  (setq eglot-server-programs
        (seq-remove (lambda (elt) (equal (cdr elt) '(eglot-deno "deno" "lsp")))
                    eglot-server-programs)))

(provide 'wh-eglot)
;;; wh-eglot.el ends here
