;;; wh-gptel.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package gptel
  :ensure t
  :bind ((:map wh-map ("l" . gptel-menu)))
  :config
  (defvar wh-gptel-mistral
    (gptel-make-openai "Mistral"
      :host "api.mistral.ai"
      :endpoint "/v1/chat/completions"
      :protocol "https"
      :stream t
      :key #'gptel-api-key-from-auth-source
      :models '(mistral-small-latest   ; cheapest, fine for quick edits
                mistral-medium-latest  ; mid-tier, pricier output
                mistral-large-latest   ; strongest general model
                codestral-latest))     ; code-focused
    "Mistral backend for gptel.")
  :custom
  (gptel-default-mode 'org-mode)

  ;; Make Mistral the default, starting on the cheap model.
  (setq gptel-backend wh-gptel-mistral
        gptel-model 'mistral-small-latest))

;; Optional: keep an offline fallback next to it (uncomment if you run Ollama).
;; (gptel-make-ollama "Ollama"
;;   :host "localhost:11434"
;;   :stream t
;;   :models '(qwen2.5-coder:7b))

(provide 'wh-gptel)

;;; wh-gptel.el ends here
