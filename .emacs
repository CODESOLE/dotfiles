;;; -*- lexical-binding: t -*-
(setq desktop-path '("." "~/.emacs.d" "~"))
(setq default-directory "~/code/")
(setq auto-save-file-name-transforms '((".*" "~/.emacs-saves/" t)))
(setq lock-file-name-transforms '((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist '((".*" . "~/.emacs-saves/")))
(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)
(menu-bar-mode 0)
(savehist-mode 1)
(electric-pair-mode 1)
(electric-indent-mode 0)
(delete-selection-mode 1)
(which-function-mode)
(editorconfig-mode)
(load-theme 'modus-vivendi t)
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
(setq imenu-flatten t)
(setq scroll-conservatively 10 scroll-margin 0)
(setq corfu-popupinfo-delay (cons 1.0 0.5))
(which-key-mode 1)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq lazy-count-suffix-format nil)
(setq search-whitespace-regexp ".*?")
(setq-default xref-show-xrefs-function #'consult-xref)
(setq-default xref-show-definitions-function #'consult-xref)
(setq completion-ignore-case t)
(global-set-key (kbd "C-,") #'xref-go-forward)
(global-set-key (kbd "C-c C-v") 'duplicate-dwim)
(global-set-key (kbd "M-Z") 'zap-up-to-char)
(with-eval-after-load 'eglot (define-key eglot-mode-map (kbd "C-c C-f") 'eglot-format))
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
  :ensure t
  :vc (:url "https://github.com/renzmann/treesit-auto.git")
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
(use-package markdown-mode :ensure t :defer t)
(use-package rust-mode :ensure t :defer t)
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eglot-highlight-symbol-face ((t (:inherit bold :background "gray14"))))
 '(eglot-inlay-hint-face ((t (:inherit shadow :background "gray2" :height 0.7))))
 '(font-lock-number-face ((t (:foreground "lightslateblue"))))
 '(font-lock-operator-face ((t (:foreground "green"))))
 '(font-lock-property-name-face ((t (:foreground "chocolate"))))
 '(font-lock-property-use-face ((t (:foreground "chocolate"))))
 '(font-lock-type-face ((t (:inherit modus-themes-bold :foreground "sea green"))))
 '(font-lock-variable-name-face ((t (:foreground "skyblue")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(avy cape consult corfu dape gdscript-mode magit marginalia
	 markdown-mode multiple-cursors odin-mode orderless rust-mode
	 treesit-auto vertico zig-mode))
 '(package-vc-selected-packages
   '((gdscript-mode :url
		    "https://github.com/godotengine/emacs-gdscript-mode")
     (treesit-auto :vc-backend Git :url
		   "https://github.com/renzmann/treesit-auto.git")))
 '(visible-bell t))
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)



