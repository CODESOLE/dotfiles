;;; -*- lexical-binding: t -*-
(setq desktop-path '("." "~/.emacs.d" "~"))
(setq default-directory "~/code/")
(setq auto-save-file-name-transforms '((".*" "~/.emacs-saves/" t)))
(setq lock-file-name-transforms '((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist '((".*" . "~/.emacs-saves/")))
(add-hook 'before-save-hook 'whitespace-cleanup)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq read-process-output-max (* 4 1024 1024))
(setq save-interprogram-paste-before-kill t)
(setq kill-do-not-save-duplicates t)
(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)
(menu-bar-mode 0)
(setq gdb-many-windows t)
(savehist-mode 1)
(electric-pair-mode 1)
(electric-indent-mode 0)
(delete-selection-mode 1)
(which-function-mode)
(editorconfig-mode 1)
(load-theme 'modus-vivendi t)
(setq reb-re-syntax 'string)
(column-number-mode 1)
(setopt treesit-font-lock-level 4)
(if (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "~/scoop/apps/git/current/bin/bash.exe")
  (setq shell-file-name explicit-shell-file-name)
  (setq explicit-bash-args '("--login" "-i"))
  (setenv "SHELL" shell-file-name))
(when (display-graphic-p)
  (set-cursor-color "yellow")
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (set-fringe-mode 0))
(setq inhibit-startup-screen t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq imenu-auto-rescan t)
(setq imenu-flatten t)
(setq scroll-conservatively 10 scroll-margin 0)
(setq set-mark-command-repeat-pop t)
(setq corfu-popupinfo-delay (cons 1.0 0.5))
(which-key-mode 1)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq lazy-count-suffix-format nil)
(setq search-whitespace-regexp ".*?")
(setq-default xref-show-xrefs-function #'consult-xref)
(setq-default xref-show-definitions-function #'consult-xref)
(setq completion-ignore-case t)
(require 'compile)
(global-set-key (kbd "C-c c") #'recompile)
(global-set-key (kbd "C-,") #'xref-go-forward)
(global-set-key (kbd "C-c v") 'duplicate-dwim)
(global-set-key (kbd "C-c f") 'consult-fd)
(global-set-key (kbd "C-c r") 'consult-ripgrep)
(with-eval-after-load 'eglot (define-key eglot-mode-map (kbd "C-c l") 'eglot-format))
(global-set-key (kbd "M-Z") 'zap-up-to-char)
(repeat-mode 1)
(recentf-mode 1)
(set-face-attribute 'mode-line-active nil :background "black")
(set-face-attribute 'mode-line-inactive nil :background "black")
(use-package markdown-mode :ensure t :defer t)
(use-package rust-mode :ensure t :defer t)
(use-package zig-mode :ensure t :defer t)
(use-package magit :ensure t :defer t)
(use-package consult :ensure t)
(use-package auctex
  :ensure t
  :defer t
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook (lambda ()
                               (visual-line-mode 1)
                               (flyspell-mode 1)
                               (LaTeX-math-mode 1)
                               (turn-on-reftex)
                               ))
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-view-program-selection '((output-pdf "Evince"))))
(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-history))
(use-package avy
  :ensure t
  :bind (("M-o" . avy-goto-char-2)))
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :config
  (setq corfu-auto t
      corfu-quit-no-match 'separator
      corfu-auto-prefix 2))
(use-package multiple-cursors
  :ensure t
  :bind (
	 ("M-n" . mc/mark-next-like-this)
	 ("M-N" . mc/skip-to-next-like-this)
	 ("M-p" . mc/mark-previous-like-this)
	 ("M-P" . mc/skip-to-previous-like-this)
	 ("C-c C-n" . mc/mark-all-like-this)))
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package vertico
  :ensure t
  :config
  (vertico-mode))
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))
(use-package dape
  :ensure t
  :defer t
  :config
  (setq dape-buffer-window-arrangement 'right)
  (add-hook 'dape-display-source-hook 'pulse-momentary-highlight-one-line)
  (setq dape-inlay-hints t)
  (add-hook 'dape-compile-hook 'kill-buffer))
(custom-set-faces
 '(eglot-highlight-symbol-face ((t (:inherit bold :background "gray14"))))
 '(eglot-inlay-hint-face ((t (:inherit shadow :background "gray2" :height 0.7))))
 '(font-lock-number-face ((t (:foreground "lightslateblue"))))
 '(font-lock-operator-face ((t (:foreground "green"))))
 '(font-lock-property-name-face ((t (:foreground "chocolate"))))
 '(font-lock-property-use-face ((t (:foreground "chocolate"))))
 '(font-lock-type-face ((t (:inherit modus-themes-bold :foreground "sea green"))))
 '(font-lock-variable-name-face ((t (:foreground "skyblue")))))
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)
