;;; -*- lexical-binding: t -*-
(set-frame-font "-outline-Cascadia Code-regular-normal-normal-mono-13-*-*-*-c-*-iso10646-1")
(set-locale-environment "ENG")
(setq auto-save-file-name-transforms '((".*" "~/.emacs-saves/" t)))
(setq lock-file-name-transforms '((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist '((".*" . "~/.emacs-saves/")))
(setq default-directory "~/code/")
(menu-bar-mode 0)
(savehist-mode 1)
(electric-pair-mode 1)
(delete-selection-mode 1)
(which-function-mode)
(editorconfig-mode)
(load-theme 'modus-vivendi t)
(column-number-mode 1)
(setopt treesit-font-lock-level 4)
(setopt compile-command "sh -c 'make -k'")
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
(global-set-key (kbd "C-,") #'xref-go-forward)
(global-set-key (kbd "C-c C-v") 'duplicate-dwim)
(global-set-key (kbd "M-Z") 'zap-up-to-char)
(setq inhibit-startup-screen t)
(setq imenu-flatten t)
(setq scroll-conservatively 10 scroll-margin 0)
(setq corfu-popupinfo-delay (cons 1.0 0.5))
(which-key-mode 1)
(setq-default flymake-indicator-type 'fringes)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq lazy-count-suffix-format nil)
(setq search-whitespace-regexp ".*?")
(setq-default xref-show-xrefs-function #'consult-xref)
(setq-default xref-show-definitions-function #'consult-xref)
(setq completion-ignore-case t)
(use-package gdscript-mode
  :vc (:url "https://github.com/godotengine/emacs-gdscript-mode")
  :ensure t
  :defer t
  :mode ("\\.gd\\'" . gdscript-mode))
(use-package odin-mode
  :ensure t
  :defer t
  :vc (:url "https://git.sr.ht/~mgmarlow/odin-mode"))
(use-package treesit-auto
  :vc (:url "https://github.com/renzmann/treesit-auto.git")
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
(use-package markdown-mode :ensure t :defer t)
(use-package rust-mode :ensure t :defer t)
(use-package rainbow-delimiters
  :defer t
  :ensure t
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package rainbow-mode :ensure t :defer t)
(use-package zig-mode :ensure t :defer t)
(use-package magit :ensure t :defer t)
(use-package consult :ensure t)
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
