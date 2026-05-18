;;; early-init.el --- Wadii's early init -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(setq load-prefer-newer t)

(defconst wh--gc-cons-threshold (* 30 1024 1024))
(defvar wh--file-name-handler-alist file-name-handler-alist)
(defvar wh--vc-handled-backends vc-handled-backends)
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil
      vc-handled-backends nil)
(defun wh--post-init ()
  "Post-initialization function."
  (setq gc-cons-threshold wh--gc-cons-threshold
        file-name-handler-alist wh--file-name-handler-alist
        vc-handled-backends wh--vc-handled-backends))
(add-hook 'after-init-hook #'wh--post-init)
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq initial-major-mode 'fundamental-mode)
(setq display-time-default-load-average nil)
(setq ring-bell-function 'ignore)
(setq use-short-answers t)
(setq read-process-output-max (* 4 1024 1024)) ; 4MB
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t  ; fine resize
      package-native-compile t) ; native compile packages
(setq native-comp-async-report-warnings-errors 'silent)
(setq native-comp-warning-on-missing-source nil)

(setq auto-revert-check-vc-info nil)

(setq inhibit-startup-echo-area-message (user-login-name))
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message user-login-name)
(setq initial-buffer-choice nil
      inhibit-startup-buffer-menu t)
(setq package-install-upgrade-built-in t)

(setq default-frame-alist '((fullscreen . maximized)))

(setq use-package-expand-minimally t)
(setq use-package-always-ensure (not noninteractive))
(setq use-package-enable-imenu-support t)

;; Enable installation of packages from MELPA.
(setq package-enable-at-startup nil)
(setq package-archives '(("melpa"        . "https://melpa.org/packages/")
                         ("gnu"          . "https://elpa.gnu.org/packages/")
                         ("nongnu"       . "https://elpa.nongnu.org/nongnu/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")))
(setq package-archive-priorities '(("gnu"    . 99)
                                   ("nongnu" . 80)
                                   ("melpa"  . 70)
                                   ("melpa-stable" . 50)))
(package-initialize)

(setq ns-use-thin-smoothing t)

;;; early-init.el ends here.
