;;; init.el --- Wadii's Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(column-number-mode 1)
(line-number-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode 1)

(global-visual-line-mode)
(global-visual-wrap-prefix-mode)

;; Show stray whitespace.
(setopt indicate-empty-lines t)
(setopt indicate-buffer-boundaries 'left)
(setopt require-final-newline t)

;; Remove message in scratch buffer.
(setopt initial-scratch-message nil)

;; Consider a period followed by a single space to be end of sentence.
(setopt sentence-end-double-space nil)

;; Use spaces, not tabs, for indentation.
(setopt indent-tabs-mode nil)

;; Display the distance between two tab stops as 4 characters wide.
(setopt tab-width 4)

(setopt enable-recursive-minibuffers t)

(setopt view-read-only t)

;; Indentation setting for various languages.
(setopt c-basic-offset 4)
(setopt js-indent-level 2)
(setopt typescript-indent-level 2)
(setopt css-indent-offset 2)

;; Write auto-saves and backups to separate directory.
(make-directory "~/.tmp/emacs/auto-save/" t)
(setopt auto-save-file-name-transforms '((".*" "~/.tmp/emacs/auto-save/" t)))
(setopt backup-directory-alist '(("." . "~/.tmp/emacs/backup/")))

;; Do not move the current file while creating backup.
(setopt backup-by-copying t)

;; Disable lockfiles.
(setopt create-lockfiles nil)
(setopt remote-file-name-inhibit-locks t)
(setopt remote-file-name-inhibit-auto-save-visited t)

(desktop-save-mode 1)

(setopt nnrss-directory (expand-file-name "news/rss" user-emacs-directory))

(setopt shell-file-name (if (eq system-type 'darwin) "/opt/homebrew/bin/fish" "fish"))
(setopt explicit-shell-file-name "bash")

(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

(setq redisplay-skip-fontification-on-input t)

(tab-bar-mode 1)

(delete-selection-mode 1)

(setopt echo-keystrokes 1e-6)

(setopt extended-command-suggest-shorter nil)

(setopt suggest-key-bindings 0)

(setopt user-full-name       "Wadii Hajji"
        user-mail-address    "wadii.hajji@proton.me")

(setopt truncate-string-ellipsis "…")

(setopt uniquify-buffer-name-style 'forward)

(setopt comint-prompt-read-only t)
(setopt comint-buffer-maximum-size 4096)

(setopt confirm-nonexistent-file-or-buffer nil)

(setopt auto-save-no-message t)

(setopt mode-line-right-align-edge 'right-margin)

(add-to-list 'trusted-content (concat user-emacs-directory "user-lisp/wh-browse.el"))
(add-to-list 'trusted-content (concat user-emacs-directory "user-lisp/wh-insert.el"))
(add-to-list 'trusted-content (concat user-emacs-directory "user-lisp/wh-eshell-prompt.el"))
(add-to-list 'trusted-content (concat user-emacs-directory "user-lisp/wh-fonts.el"))
(add-to-list 'trusted-content (concat user-emacs-directory "user-lisp/wh-lsp.el"))
(add-to-list 'trusted-content (concat user-emacs-directory "user-lisp/wh-tenderbolt.el"))
(add-to-list 'trusted-content (concat user-emacs-directory "user-lisp/wh-embark-browse.el"))
(add-to-list 'trusted-content (concat user-emacs-directory "early-init.el"))

(defvar-keymap wh-notes-map
  :doc "Keymap for my notes commands."
  :prefix #'wh-notes-prefix-map)
(defvar-keymap wh-map
  :doc "Keymap for my commands."
  :prefix #'wh-prefix-map
  "r" wh-notes-map)

(require 'package)
(unless package-archive-contents
  (package-refresh-contents))

(use-package find-file
  :ensure nil
  :custom
  (find-file-visit-truename t)
  (vc-follow-symlinks t))
(use-package imenu
  :ensure nil
  :custom
  (imenu-auto-rescan t)
  (imenu-max-item-length 160))
(use-package goto-addr
  :ensure nil
  :commands (goto-address-mode)
  :hook (prog-mode . goto-address-prog-mode))
(use-package xref
  :ensure nil
  :config (global-xref-mouse-mode +1)
  :custom
  (xref-search-program 'ripgrep)
  (xref-show-xrefs-function #'consult-xref)
  (xref-show-definitions-function #'consult-xref))
(use-package display-fill-column-indicator
  :ensure nil
  :hook ((text-mode prog-mode) . display-fill-column-indicator-mode))
(use-package tramp
  :ensure nil
  :config
  (connection-local-set-profile-variables
   'remote-direct-async-process
   '((tramp-direct-async-process . t)))
  (connection-local-set-profiles
   '(:application tramp :protocol "scp")
   'remote-direct-async-process)
  :custom
  (tramp-use-scp-direct-remote-copying t)
  (tramp-copy-size-limit (* 1024 1024)) ;; 1MB
  (tramp-verbose 2))
(use-package isearch
  :ensure nil
  :custom
  (isearch-allow-motion t)
  (isearch-allow-scroll 'unlimited)
  (isearch-repeat-on-direction-change t)
  (isearch-wrap-pause 'no)
  (isearch-lazy-count t)
  (search-default-mode #'char-fold-to-regexp))
(use-package ibuffer
  :ensure nil
  :bind ([remap list-buffers] . ibuffer))
(use-package hippie-expand
  :ensure nil
  :bind ([remap dabbrev-expand] . hippie-expand))
(use-package diminish
  :ensure t)
(use-package minions
  :ensure t
  :config
  (minions-mode)
  :custom
  (minions-mode-line-lighter "…")
  (minions-prominent-modes '(flymake-mode lsp-mode)))
(use-package dired
  :ensure nil
  :bind (:map dired-mode-map
              ("_" . dired-create-empty-file))
  :custom
  (dired-dwim-target t)
  (dired-listing-switches "-vhal --group-directories-first")
  (dired-mouse-drag-files t)
  (dired-use-ls-dired t)
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (dired-create-destination-dirs 'ask)
  (dired-kill-when-opening-new-dired-buffer t)
  (dired-auto-revert-buffer t)
  (insert-directory-program (if (eq system-type 'darwin) "gls" "ls"))
  (delete-by-moving-to-trash nil))
(use-package dired-x
  :ensure nil
  :after dired
  :hook
  (dired-mode . dired-omit-mode)
  (dired-mode . dired-hide-details-mode)
  (dired-mode . hl-line-mode)
  :custom
  (dired-omit-size-limit 60000)
  (dired-omit-verbose nil))
(use-package dired-filter
  :after dired
  :ensure t
  :bind (:map dired-mode-map ("/" . dired-filter-map)))
(use-package hl-line
  :ensure nil
  :hook ((text-mode prog-mode tabulated-list-mode) . hl-line-mode))
(use-package hl-todo
  :ensure t)
(use-package dired-aux
  :ensure nil
  :custom
  (dired-vc-rename-file t))
(use-package nerd-icons
  :ensure t
  :config
  (add-to-list 'nerd-icons-mode-icon-alist '(ghostel-mode nerd-icons-mdicon "nf-md-ghost" :face nerd-icons-purple))
  :custom
  (nerd-icons-font-family "Symbols Nerd Font Mono"))
(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))
(use-package nerd-icons-completion
  :ensure t
  :hook (marginalia-mode . nerd-icons-completion-marginalia-setup))
(use-package fish-completion
  :ensure t
  :hook (eshell-mode . fish-completion-mode))
(use-package rainbow-mode
  :ensure t
  :custom
  (rainbow-ansi-colors nil)
  (rainbow-x-colors nil)
  :bind (:map ctl-x-x-map
              ("c" . rainbow-mode)))
(use-package tab-bar
  :ensure nil
  :bind ("s-t" . tab-new)
  :custom
  (tab-bar-auto-width nil)
  (tab-bar-new-button-show t)
  (tab-bar-close-button-show t))
(use-package winner
  :ensure nil
  :init (winner-mode))
(use-package paren
  :ensure nil
  :custom
  (show-paren-delay 0.1)
  (show-paren-highlight-openparen t)
  (show-paren-when-point-inside-paren t)
  (show-paren-when-point-in-periphery t)
  :config
  (show-paren-mode))
(use-package windsize
  :ensure t
  :hook (after-init . windsize-default-keybindings))
(use-package window
  :ensure nil
  :config
  (add-to-list 'display-buffer-alist
               '("\\*Help"
                 (display-buffer-same-window)))
  (add-to-list 'display-buffer-alist
               '("\\*info"
                 (display-buffer-same-window)))
  (add-to-list 'display-buffer-alist
               '("\\*helpful"
                 (display-buffer-same-window)))
  :bind
  (:map window-prefix-map ("R" . unbury-buffer))
  :custom
  (same-window-buffer-names nil)
  (same-window-regexps nil)
  (switch-to-buffer-obey-display-actions t))
(use-package repeat
  :ensure nil
  :hook (after-init . repeat-mode))
(use-package mb-depth
  :ensure nil
  :init (minibuffer-depth-indicate-mode 1))
(use-package emacs
  :init
  (setq minibuffer-prompt-properties
        '(read-only t intangible t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
  (add-hook 'after-save-hook
            'executable-make-buffer-file-executable-if-script-p)
  :bind
  ("M-z" . zap-up-to-char)
  ("M-Z" . zap-to-char)
  ("C-M-z" . delete-pair)
  ("C-M-j" . duplicate-dwim)
  ("M-u" . upcase-dwim)
  ("M-l" . downcase-dwim)
  ("M-c" . capitalize-dwim)
  ("M-=" . count-words)
  ("C-x O" . (lambda ()
               (interactive)
               (setq repeat-map 'other-window-repeat-map)
               (other-window -1)))
  ("M-g M-c" . switch-to-minibuffer)
  ("C-x C-#" . server-edit-abort)
  :bind-keymap ("C-c w" . wh-map)
  :custom
  (tab-always-indent t)
  (default-transient-input-method "latin-1-prefix")
  (text-mode-ispell-word-completion nil)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (comment-fill-column 80)
  (x-underline-at-descent-line t)
  (auto-revert-avoid-polling t)
  (custom-safe-themes t)
  (set-mark-command-repeat-pop t)
  (save-interprogram-paste-before-kill t)
  (kill-do-not-save-duplicates t)
  (mouse-yank-at-point t)
  (compilation-max-output-line-length nil)
  (yank-excluded-properties t))
(use-package autorevert
  :ensure nil
  :config
  (setq auto-revert-interval 1)
  (global-auto-revert-mode +1)
  :custom
  (global-auto-revert-non-file-buffers t))
(use-package whitespace
  :ensure nil
  :hook
  ((prog-mode text-mode) . whitespace-mode)
  :custom
  (whitespace-style '(face trailing empty tabs)))
(use-package simple
  :ensure nil
  :custom
  (visual-line-fringe-indicators '(left-curly-arrow nil))
  (visual-wrap-extra-indent 2))
(use-package time
  :ensure nil
  :custom
  (world-clock-list '(("America/Chicago" "Chicago")
                      ("America/Montreal" "Montreal")
                      ("Europe/Paris" "Paris")
                      ("Africa/Casablanca" "Rabat"))))
(use-package async
  :ensure t)
(use-package which-func
  :ensure nil
  :custom
  (which-func-update-delay 1.0))
(use-package project
  :ensure nil
  :bind
  :custom
  (project-vc-extra-root-markers '(".project"))
  (project-switch-commands '((project-find-file "Find" ?f)
                             (project-find-dir "Directory" ?d)
                             (consult-ripgrep "Ripgrep" ?r)
                             (magit-project-status "Magit" ?m)
                             (magit-project-dispatch "Magit Dispatch" ?M)
                             (project-eshell "Eshell" ?e)
                             (consult-project-buffer "Buffers" ?b)
                             (ghostel-project "Term" ?t)
                             (project-any-command "Other" ?o)
                             (casual-editkit-project-tmenu "Help" ??))))
(use-package savehist
  :ensure nil
  :custom
  (history-length 1000)
  (history-delete-duplicates t)
  (savehist-save-minibuffer-history t)
  (savehist-additional-variables nil)
  :init
  (savehist-mode 1))
(use-package undo-fu-session
  :ensure t
  :config (undo-fu-session-global-mode))
(use-package minibuffer
  :ensure nil
  :custom
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (completion-cycle-threshold nil)
  (completion-ignore-case t)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :bind
  (:map vertico-map
        ("RET" . vertico-directory-enter)
        ("DEL" . vertico-directory-delete-char)
        ("M-DEL" . vertico-directory-delete-word))
  :init
  (vertico-mode +1)
  (vertico-mouse-mode -1))
(use-package vertico-directory
  :ensure nil
  :after vertico)
(use-package vertico-repeat
  :after vertico
  :ensure nil
  :bind
  ("M-R" . vertico-repeat-select)
  :hook
  (minibuffer-setup . vertico-repeat-save))
(use-package tmm
  :ensure nil
  :config
  (advice-add #'tmm-add-prompt :after #'minibuffer-hide-completions))
(use-package ffap
  :ensure nil
  :custom
  (ffap-machine-p-known 'reject)
  :config
  (advice-add #'ffap-menu-ask :around
              (lambda (&rest args)
                (cl-letf (((symbol-function #'minibuffer-completion-help)
                           #'ignore))
                  (apply args)))))
(use-package markdown-mode
  :ensure t
  :custom
  (markdown-command "pandoc")
  (markdown-fontify-code-blocks-natively nil))
(use-package rainbow-delimiters
  :ensure t
  :hook ((emacs-lisp-mode ielm-mode lisp-interaction-mode lisp-mode) . rainbow-delimiters-mode))
(use-package magit
  :ensure t
  :after transient
  :pin nongnu
  :bind
  (:map project-prefix-map
        ("m" . magit-project-status)
        ("M" . magit-project-dispatch))
  :config
  (magit-add-section-hook 'magit-status-sections-hook 'magit-insert-worktrees nil t)
  (magit-add-section-hook 'magit-status-sections-hook 'magit-insert-modules nil t)
  :custom
  (magit-define-global-key-bindings 'recommended)
  (magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)
  (magit-format-file-function 'magit-format-file-nerd-icons)
  (magit-save-repository-buffers nil)
  (magit-process-apply-ansi-colors t)
  (magit-repository-directories '(("~/dev/sources". 1)))
  (magit-tramp-pipe-stty-settings 'pty)
  (magit-diff-refine-hunk t)
  (magit-diff-fontify-hunk nil)
  (magit-diff-specify-hunk-foreground t)
  (magit-diff-use-indicator-faces t)
  (magit-delete-by-moving-to-trash nil)
  (magit-branch-name-suggestions '("wh/")))
(use-package forge
  :ensure t
  :after magit
  :custom
  (forge-database-file "~/.config/forge/database.sqlite")
  (forge-owned-accounts '(("hwadii"))))
(use-package transient
  :pin melpa
  :ensure t)
(use-package doc-view
  :ensure nil
  :custom
  (doc-view-resolution 300))
(use-package pdf-tools
  :ensure t
  :custom
  (pdf-view-display-size 'fit-page))
(use-package org
  :ensure t
  :pin gnu
  :init
  (require 'ox-md)
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)
     (emacs-lisp . t)
     (sql . t)))
  :bind
  ("C-h ." . display-local-help)
  :custom
  (org-hide-emphasis-markers nil)
  :hook
  (org-mode . auto-fill-mode))
(use-package org-modern
  :ensure t
  :custom
  (org-modern-checkbox nil)
  (org-modern-star 'fold)
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize-hook . org-modern-agenda))
(use-package verb
  :ensure t
  :after org
  :config (keymap-set org-mode-map "C-c C-r" verb-command-map))
(use-package re-builder
  :ensure nil
  :custom
  (reb-re-syntax 'string))
(use-package diff-hl
  :ensure t
  :hook ((magit-post-refresh . diff-hl-magit-post-refresh)
         (magit-pre-refresh . diff-hl-magit-pre-refresh)
         (dired-mode . diff-hl-dired-mode-unless-remote))
  :config (global-diff-hl-mode)
  :custom
  (diff-hl-flydiff-mode t)
  (diff-hl-draw-borders nil)
  (diff-hl-show-staged-changes nil))
(use-package ediff
  :ensure nil
  :init
  (defvar ue-ediff-window-config nil "Window config before ediffing")
  :hook
  ((ediff-before-setup . (lambda ()
                           (setq ue-ediff-window-config (current-window-configuration))))
   ((ediff-suspend ediff-quit) . (lambda () (set-window-configuration ue-ediff-window-config)))
   (ediff-cleanup . (lambda () (ediff-janitor t nil))))
  :custom
  (ediff-window-setup-function 'ediff-setup-windows-plain)
  (ediff-split-window-function 'split-window-horizontally))
(use-package diff
  :ensure nil
  :custom
  (diff-font-lock-syntax nil)
  (diff-font-lock-prettify t))
(use-package shr
  :ensure nil
  :custom
  (shr-use-colors nil)
  (shr-use-fonts nil))
(use-package treesit
  :ensure nil
  :custom
  (treesit-enabled-modes t)
  (treesit-auto-install-grammar 'ask))
(use-package rust-mode :ensure t)
(use-package json-mode :ensure t)
(use-package zig-mode :ensure t)
(use-package zig-ts-mode
  :ensure t
  :mode "\\.zig\\'")
(use-package ruby-mode
  :ensure t
  :config
  :hook (ruby-ts-mode . (lambda ()
                          (setq fill-column 140)))
  :custom
  (ruby-method-call-indent nil)
  (ruby-method-params-indent nil)
  (ruby-bracketed-args-indent nil)
  (ruby-flymake-use-rubocop-if-available t))
(use-package scala-ts-mode
  :ensure t
  :mode "\\.scala'")
(use-package apheleia
  :ensure t
  :config
  (setf (alist-get 'python-mode apheleia-mode-alist) '(ruff-isort ruff))
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) '(ruff-isort ruff))
  (add-to-list 'apheleia-formatters '(csharpier "dotnet" "csharpier" "--write-stdout"))
  :bind ("C-c l f" . apheleia-format-buffer))
(use-package csharp-mode
  :ensure nil
  :hook ((csharp-mode csharp-ts-mode) . (lambda () (setq fill-column 120))))
(use-package remember
  :ensure nil
  :config
  (defun wh-find-notes-file ()
    "Find notes file from notes directory."
    (interactive)
    (find-file "~/code/notes/notes"))
  :bind (:map wh-notes-map
              ("r" . remember)
              ("o" . remember-notes)
              ("n" . wh-find-notes-file))
  :custom
  (remember-notes-initial-major-mode 'org-mode)
  (remember-in-new-frame t)
  (remember-data-file "~/code/notes/remember"))
(use-package corfu
  :ensure t
  :after orderless
  :init
  (global-corfu-mode)
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  :custom
  (corfu-auto nil)
  (corfu-cycle t)
  :hook
  (corfu-mode . (lambda ()
                  (setq-local completion-styles '(orderless-literal-only basic)
                              completion-category-overrides nil
                              completion-category-defaults nil))))
(use-package corfu-popupinfo
  :ensure nil
  :after corfu
  :custom
  (corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-hide t)
  (corfu-preview-current nil)
  :config
  (corfu-popupinfo-mode 1))
(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map))
(use-package ghostel
  :ensure t
  :pin melpa
  :bind
  (:map project-prefix-map
        ("t" . ghostel-project)
        ("T" . ghostel-project-list-buffers))
  :custom
  (ghostel-shell shell-file-name))
(use-package ghostel-eshell
  :ensure nil
  :hook (eshell-load . ghostel-eshell-visual-command-mode))
(use-package ghostel-compile
  :ensure nil
  :config (ghostel-compile-global-mode))
(use-package which-key
  :ensure nil
  :pin gnu
  :custom
  (which-key-echo-keystrokes echo-keystrokes)
  (which-key-show-early-on-C-h t)
  (which-key-idle-delay 10000.1)
  (which-key-idle-secondary-delay 0.05)
  :config (which-key-mode))
(use-package ansi-color
  :ensure nil
  :hook (compilation-filter . ansi-color-compilation-filter)
  :config
  (defun wh-ansi-apply-color-on-buffer ()
    (interactive)
    (ansi-color-apply-on-region (point-min) (point-max) 'replace)))
(use-package fish-mode
  :ensure t)
(use-package jinx
  :ensure t
  :hook ((markdown-mode org-mode tex-mode) . jinx-mode)
  :bind
  ("M-$" . jinx-correct)
  ("C-M-$" . jinx-languages))
(use-package password-store
  :pin melpa
  :ensure t)
(use-package rg
  :ensure t
  :config (rg-enable-default-bindings)
  :custom
  (rg-executable "rg"))
(use-package rg-isearch
  :ensure nil
  :after rg
  :bind (:map isearch-mode-map ("M-s R" . rg-isearch-menu)))
(use-package eshell
  :ensure nil
  :bind
  ("C-x C-z" . eshell)
  :hook
  (eshell-mode . abbrev-mode)
  (eshell-mode . goto-address-mode)
  :config
  (defalias 'eshell/v 'eshell/ghostel)
  (defun adviced:eshell/cat (orig-fun &rest args)
    "Like `eshell/cat' but with image support."
    (if (seq-every-p (lambda (arg)
                       (and (stringp arg)
                            (file-exists-p arg)
                            (image-supported-file-p arg)))
                     args)
        (with-temp-buffer
          (insert "\n")
          (dolist (path args)
            (let ((spec (create-image
                         (expand-file-name path)
                         (image-type-from-file-name path)
                         nil :max-width 350
                         :conversion (lambda (data) data))))
              (image-flush spec)
              (insert-image spec))
            (insert "\n"))
          (insert "\n")
          (buffer-string))
      (apply orig-fun args)))
  (advice-add #'eshell/cat :around #'adviced:eshell/cat)
  (defun wh-pwd-replace-home (pwd)
    "Replace home in PWD with tilde (~) character."
    (let* ((home (expand-file-name (getenv "HOME")))
           (home-len (length home)))
      (if (and
           (>= (length pwd) home-len)
           (equal home (substring pwd 0 home-len)))
          (concat "~" (substring pwd home-len))
        pwd)))
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
        pwd)))  ;; Otherwise, we just return the PWD
  :custom
  (eshell-prefer-lisp-functions t)
  (eshell-scroll-to-bottom-on-output nil)
  (eshell-scroll-show-maximum-output nil)
  (eshell-banner-message "")
  (eshell-history-size (* 1024 256))
  (eshell-history-append t)
  (eshell-hist-ignoredups t)
  (eshell-buffer-maximum-lines 4096)
  (eshell-prompt-function #'wh-eshell-prompt-fn)
  (eshell-visual-subcommands '(("kubectl" "exec") ("tsh" "ssh")))
  (eshell-visual-commands '("nvim" "tmux" "top" "htop" "less" "newsboat" "nu")))
(use-package em-hist
  :ensure nil
  :after consult
  :bind
  (:map eshell-hist-mode-map
        ("M-s" . nil)
        ("M-r" . nil)))
(use-package marginalia
  :ensure t
  :custom (marginalia-mode 1))
(use-package orderless
  :ensure t
  :after vertico
  :config
  (orderless-define-completion-style orderless-literal-only
    (orderless-style-dispatchers nil)
    (orderless-matching-styles '(orderless-literal)))
  :custom
  (orderless-matching-styles '(orderless-literal orderless-regexp)))
(use-package casual
  :ensure t
  :init (casual-init)
  :custom
  (casual-init-hook
   '(casual-agenda-init casual-calc-init casual-calendar-init
                        casual-dired-init casual-eshell-init
                        casual-eww-init casual-help-init
                        casual-ibuffer-init casual-image-init
                        casual-info-init casual-compile-init
                        casual-man-init casual-org-init casual-re-builder-init))
  (casual-lib-use-unicode nil)
  :bind
  (:map wh-map ("t" . casual-timezone-tmenu))
  (:map project-prefix-map ("?" . casual-editkit-project-tmenu)))
(use-package casual-avy
  :ensure t
  :after casual)
(use-package ef-themes
  :after modus-themes
  :ensure t)
(use-package envrc
  :ensure t
  :if (not (eq system-type 'darwin))
  :init (envrc-global-mode)
  :bind ("C-c e" . envrc-command-map))
(use-package no-littering
  :ensure t
  :config
  (setopt custom-file (no-littering-expand-etc-file-name "custom.el")))
(use-package helpful
  :ensure t
  :bind (([remap describe-command] . helpful-command)
         ([remap describe-function] . helpful-callable)
         ([remap describe-key] . helpful-key)
         ([remap describe-symbol] . helpful-symbol)
         ([remap describe-variable] . helpful-variable)
         ("C-h F" . helpful-function)
         ("C-h K" . describe-keymap)
         :map helpful-mode-map
         ([remap revert-buffer] . helpful-update)))
(use-package operate-on-number
  :ensure t
  :config
  (defvar-keymap operate-on-number-repeat-map
    :repeat t
    "+" #'apply-operation-to-number-at-point
    "-" #'apply-operation-to-number-at-point)
  (define-key global-map (kbd "C-c n") operate-on-number-repeat-map))
(use-package embark
  :ensure t
  :bind
  ("C-." . embark-act)
  ("C-;" . embark-dwim)
  ("C-h B" . embark-bindings) ;; alternative for `describe-bindings'
  (:map embark-general-map
        ("W" . dictionary-search))
  :custom
  (embark-indicators
   '(embark-minimal-indicator  ; default is embark-mixed-indicator
     embark-highlight-indicator
     embark-isearch-highlight-indicator))
  (embark-quit-after-action t))
(use-package dictionary
  :ensure nil
  :custom
  (dictionary-server "dict.org"))
(use-package server
  :ensure nil
  :defer 1
  :custom
  (server-client-instructions nil)
  :config
  (unless (server-running-p)
    ;; Start server.
    (server-start)))
(use-package so-long
  :ensure nil
  :config (global-so-long-mode))
(use-package avy
  :ensure t
  :config
  (defun avy-action-embark (pt)
    (unwind-protect
        (save-excursion
          (goto-char pt)
          (embark-act))
      (select-window
       (cdr (ring-ref avy-ring 0))))
    t)
  (setf (alist-get ?. avy-dispatch-alist) 'avy-action-embark)
  :bind
  ("s-:" . casual-avy-tmenu))
(use-package ace-window
  :ensure t
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  ("M-o" . ace-window))
(use-package calendar
  :ensure nil
  :bind (:map wh-map ("c" . calendar))
  :custom
  (calendar-week-start-day 1)
  (calendar-latitude [48 51 24 north])
  (calendar-longitude [2 21 07 east])
  (calendar-location-name "Paris, FR")
  (calendar-mark-holidays t)
  (calendar-mark-diary-flags t))
(use-package consult
  :bind
  ("C-c M-x" . consult-mode-command)
  ("C-c h" . consult-history)
  ("C-c m" . consult-man)
  ("C-c i" . consult-info)
  ([remap Info-search] . consult-info)
  ("C-x b" . consult-buffer)
  ("C-x 4 b" . consult-buffer-other-window)
  ("C-x 5 b" . consult-buffer-other-frame)
  ("C-x t b" . consult-buffer-other-tab)
  ("C-x r b" . consult-bookmark)
  ("C-x p b" . consult-project-buffer)
  ("C-x M-:" . consult-complex-command)
  ("C-x r b" . consult-bookmark)
  ("M-g M-e" . consult-compile-error)
  ("M-g M-f" . consult-flymake)
  ("M-g M-g" . consult-goto-line)
  ("M-g M-o" . consult-outline)
  ("M-g M-i" . consult-imenu)
  ("M-g M-m" . consult-mark)
  ("M-g M-SPC" . consult-global-mark)
  ("M-s M-y" . consult-yank-pop)
  ("M-s M-d" . consult-fd)
  ("M-s M-r" . consult-ripgrep)
  ("M-s M-l" . consult-line)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  :custom
  (consult-narrow-key "<") ;; "C-+"
  (consult-man-args "man -k"))
(use-package embark-consult
  :ensure t
  :after (embark consult))
(use-package mouse
  :ensure nil
  :config (context-menu-mode))
(use-package mwheel
  :ensure nil
  :custom
  (mouse-wheel-tilt-scroll t)
  (mouse-wheel-flip-direction t))
(use-package ultra-scroll
  :ensure t
  :config
  (ultra-scroll-mode 1)
  :custom
  (scroll-conservatively 3)
  (scroll-margin 0))
(use-package go-ts-mode
  :ensure nil
  :config
  (add-to-list 'auto-mode-alist '("/go\\.mod\\'" . go-mod-ts-mode))
  (add-to-list 'auto-mode-alist '("/go\\.work\\'" . go-work-ts-mode))
  :custom
  (go-ts-mode-indent-offset 4))
(use-package nushell-ts-mode
  :ensure t)
(use-package git-link
  :ensure t
  :bind (:map wh-map ("g" . git-link-dispatch)))
(use-package modus-themes
  :ensure t
  :init
  (modus-themes-include-derivatives-mode)
  :custom
  (modus-themes-mixed-fonts t)
  (modus-themes-variable-pitch-ui t)
  (modus-themes-italic-constructs t)
  (modus-themes-bold-constructs t))
(use-package smtpmail
  :ensure nil
  :custom
  (smtpmail-smtp-server "127.0.0.1")
  (smtpmail-smtp-service 1025)
  (smtpmail-stream-type 'starttls)
  (smtpmail-smtp-user "wadii.hajji@proton.me"))
(use-package sendmail
  :ensure nil
  :custom
  (send-mail-function #'smtpmail-send-it))
(use-package gnus
  :ensure nil
  :custom
  (gnus-select-method '(nnnil ""))
  (gnus-secondary-select-methods
   '((nnimap "proton"
             (nnimap-address "127.0.0.1")
             (nnimap-server-port 1143)
             (nnimap-stream starttls)
             (nnimap-authenticator login))))
  (gnus-permanently-visible-groups "INBOX\\|Sent\\|Archive")
  (message-send-mail-function #'smtpmail-send-it))
(use-package eldoc-box
  :disabled
  :ensure t
  :hook
  ((eglot-managed-mode lsp-mode) . eldoc-box-hover-mode)
  (eldoc-box-buffer-setup-hook . eldoc-box-prettify-ts-errors)
  :config
  (set-face-attribute 'eldoc-box-body nil :inherit 'variable-pitch)
  :custom
  (eldoc-box-clear-with-C-g t)
  :bind (("C-h ." . eldoc-box-help-at-point)))
(use-package eldoc
  :ensure nil
  :custom
  (eldoc-echo-area-prefer-doc-buffer t)
  (eldoc-echo-area-use-multiline-p nil))
(use-package transpose-frame
  :ensure t)
(use-package editorconfig
  :ensure nil
  :pin gnu
  :init
  (editorconfig-mode 1))
(use-package exec-path-from-shell
  :ensure t
  :if (eq system-type 'darwin)
  :init
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs '("PASSWORD_STORE_DIR" "BROWSER" "COMPOSE_BAKE" "XDG_CONFIG_HOME" "RIPGREP_CONFIG_PATH"
                                    "EDITOR" "VISUAL" "PRE_COMMIT_COLOR" "LSP_USE_PLISTS" "LESS" "LS_COLORS" "LANG" "LC_ALL"
                                    "LANGUAGE" "HOMEBREW_NO_EMOJI" "DOTNET_WATCH_SUPPRESS_EMOJIS" "SSH_AUTH_SOCK")))
(use-package jq-mode
  :ensure t
  :commands jq-interactively
  :bind (:map json-mode-map
              ("C-c C-j" . jq-interactively)))
(use-package kdl-mode
  :mode "\\.kdl\\'"
  :ensure t)
(use-package expreg
  :ensure t
  :config
  (defvar-keymap expreg-repeat-map
    :repeat t
    "=" #'expreg-expand
    "-" #'expreg-contract)
  :bind (("C-=" . expreg-expand)
         ("C--" . expreg-contract)))
(use-package surround
  :ensure t
  :bind-keymap ("M-+" . surround-keymap))
(use-package csv-mode
  :ensure t)
(use-package just-ts-mode
  :ensure t)
(use-package nix-ts-mode
  :mode "\\.nix\\'"
  :ensure t)
(use-package visual-replace
  :ensure t
  :custom
  (visual-replace-default-to-full-scope t))
(use-package doom-modeline
  :ensure t
  :pin melpa
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-minor-modes t)
  (doom-modeline-vcs-max-length 15)
  (doom-modeline-workspace-name nil)
  (doom-modeline-column-zero-based nil)
  (doom-modeline-total-line-number t)
  (doom-modeline-env-enable-ruby nil)
  (doom-modeline-icon t)
  (doom-modeline-lsp t)
  (doom-modeline-check 'simple))
(use-package man
  :ensure nil
  :custom
  (Man-switches "-a")
  (Man-notify-method 'pushy))
(use-package stillness-mode
  :ensure t
  :init (stillness-mode))
(use-package request
  :ensure t)
(use-package elfeed
  :pin melpa
  :ensure t
  :commands elfeed
  :custom
  (elfeed-feeds '(("fever+https://wadii@feed.exondation.com"
                   :api-url "https://feed.exondation.com/fever/"
                   :use-authinfo t))))
(use-package elfeed-protocol
  :ensure t
  :after elfeed
  :config
  (elfeed-protocol-enable)
  :custom
  (elfeed-protocol-fever-update-unread-only t)
  (elfeed-protocol-fever-fetch-category-as-tag t))
(use-package ns-auto-titlebar
  :ensure t
  :if (eq system-type 'darwin)
  :config (ns-auto-titlebar-mode))
(use-package doric-themes
  :ensure t)
(use-package posframe
  :ensure t
  :pin gnu)
(use-package htmlize
  :ensure t)
(use-package typst-ts-mode
  :ensure t)
(use-package typescript-ts-mode
  :ensure nil
  :mode "\\.mts\\'")
(use-package ddgr
  :ensure t)
(use-package tempel
  :ensure t
  :bind ("M-*" . tempel-complete))
(use-package sql
  :ensure nil
  :custom
  (sql-postgres-login-params '(user password server database port)))
(use-package js
  :ensure nil
  :mode
  ("\\.mjs$" . js-ts-mode))

(setopt disabled-command-function nil)

(load custom-file t)
(require 'wh-browse)
(require 'wh-insert)
(require 'wh-eshell-prompt)
(require 'wh-lsp)
(require 'wh-fonts)
(when (string-equal (system-name) "silverwing")
  (require 'wh-tenderbolt))
(require 'wh-embark-browse)

(provide 'init)

;;; init.el ends here
