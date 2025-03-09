;;; -*- lexical-binding: t -*-
(menu-bar-mode 0)
(electric-pair-mode 1)
(load-theme 'modus-vivendi t)
(column-number-mode 1)
(add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))
(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
(add-to-list 'major-mode-remap-alist '(c-or-c++-mode . c-or-c++-ts-mode))
(when (display-graphic-p)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (set-fringe-mode 0))
(setq inhibit-startup-screen t)
(which-key-mode 1)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq lazy-count-suffix-format nil)
(setq search-whitespace-regexp ".*?")

(use-package rust-mode :ensure t)
(use-package zig-mode :ensure t)
(use-package magit :ensure t)
(use-package consult :ensure t)

(use-package breadcrumb
  :ensure t
  :config
  (breadcrumb-mode))

(use-package avy
  :ensure t
  :bind (("M-o" . avy-goto-char-2)))

(use-package company
  :ensure t
  :init (add-hook 'after-init-hook #'global-company-mode))

(use-package multiple-cursors
  :ensure t
  :bind (("M-n" . mc/mark-next-like-this) ("M-p" . mc/mark-previous-like-this) ("C-c C-n" . mc/mark-all-like-this)))

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
