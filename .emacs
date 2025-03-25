;;; -*- lexical-binding: t -*-
(menu-bar-mode 0)
(electric-pair-mode 1)
(which-function-mode)
(savehist-mode 1)
(editorconfig-mode)
(load-theme 'modus-vivendi t)
(column-number-mode 1)
(delete-selection-mode 1)
(when (display-graphic-p)
  (set-cursor-color "yellow")
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (set-fringe-mode 0))
(global-set-key (kbd "C-c C-v") 'duplicate-dwim)
(global-set-key (kbd "M-Z") 'zap-up-to-char)
(setq inhibit-startup-screen t)
(setq imenu-flatten t)
(which-key-mode 1)
(setq-default flymake-indicator-type 'fringes)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq lazy-count-suffix-format nil)
(setq search-whitespace-regexp ".*?")
(setq-default xref-show-xrefs-function #'consult-xref)
(setq-default xref-show-definitions-function #'consult-xref)
(setq completion-ignore-case t)
(use-package markdown-mode :ensure t)
(use-package rust-mode :ensure t)
(use-package zig-mode :ensure t)
(use-package magit :ensure t)
(use-package consult :ensure t)
(use-package rainbow-delimiters-mode
  :ensure t
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package rainbow-mode :ensure t)
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
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
(defadvice vc-git-mode-line-string (after plus-minus (file) compile activate)
  (setq ad-return-value
    (concat ad-return-value
            (let ((plus-minus (vc-git--run-command-string
                               file "diff" "--numstat" "--")))
              (and plus-minus
                   (string-match "^\\([0-9]+\\)\t\\([0-9]+\\)\t" plus-minus)
                   (format " +%s-%s" (match-string 1 plus-minus) (match-string 2 plus-minus)))))))
