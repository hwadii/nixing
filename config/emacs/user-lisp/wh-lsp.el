;;; wh-lsp.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package eglot
  :ensure t
  :custom
  (eglot-autoshutdown t)
  (eglot-autoreconnect t)
  (eglot-sync-connect 1)
  (eglot-events-buffer-config :size 0)
  (eglot-confirm-server-edits nil)
  (eglot-extend-to-xref t)
  (eglot-connection-timeout 60)
  (eglot-code-action-indications '(eldoc-hint))
  (eglot-ignored-server-capabilities '(:semanticTokensProvider))
  :bind
  ("C-c l c" . eglot-reconnect)
  ("C-c l l" . eglot)
  ("C-c l r" . eglot-rename)
  ("C-c l s" . eglot-shutdown)
  ("C-c l h" . eglot-inlay-hints-mode)
  ("C-c l i" . eglot-find-implementation)
  ("C-c l a" . eglot-code-actions)
  ("C-c l o" . eglot-code-action-organize-imports)
  ("C-c l m" . flymake-show-buffer-diagnostics)
  ("C-c l x" . eglot-reconnect)
  :config
  (add-to-list 'eglot-server-programs '((ruby-mode ruby-ts-mode) . ("ruby-lsp")))
  (add-to-list 'eglot-server-programs '(scala-ts-mode . ("metals")) t)
  (add-to-list 'eglot-server-programs '(zig-ts-mode . ("zls")) t)
  (add-to-list 'eglot-server-programs '(nix-ts-mode . ("nil")) t)
  (add-to-list 'eglot-server-programs '((tsx-mode tsx-ts-mode) . ("tailwindcss-language-server" "--stdio")) t)
  :hook
  (eglot-managed-mode . (lambda () (eglot-inlay-hints-mode -1)))
  ((typescript-mode typescript-ts-mode tsx-ts-mode) . eglot-ensure))

(use-package breadcrumb
  :ensure t
  :bind
  ("C-c l b" . breadcrumb-local-mode))

(use-package lsp-mode
  :ensure t
  :diminish (lsp-mode . "LSP")
  :custom
  (lsp-eldoc-render-all t)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-modeline-code-actions-enable nil)
  (lsp-modeline-diagnostics-enable nil)
  (lsp-enable-snippet nil)
  (lsp-enable-suggest-server-download nil)
  (lsp-auto-guess-root t)
  (lsp-progress-prefix nil)
  (lsp-disabled-clients '(ruby-ls rubocop-ls angular-ls tailwindcss))
  (lsp-enable-indentation nil)
  :hook
  (lsp-mode . lsp-enable-which-key-integration))

(use-package flymake
  :ensure nil
  :hook (prog-mode . flymake-mode)
  :config
  (defvar-keymap flymake-goto-repeat-map
    :repeat t
    "n" #'flymake-goto-next-error
    "p" #'flymake-goto-prev-error)
  :bind
  (:map flymake-mode-map
        ("C-c ! n" . flymake-goto-next-error)
        ("C-c ! p" . flymake-goto-prev-error))
  :custom
  (flymake-show-diagnostics-at-end-of-line nil)
  (flymake-no-changes-timeout 0.5))

(provide 'wh-lsp)
;;; wh-eglot.el ends here
