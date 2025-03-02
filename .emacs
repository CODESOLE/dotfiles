;;; -*- lexical-binding: t -*-
(custom-set-variables
 '(custom-enabled-themes '(modus-vivendi))
 '(package-selected-packages
   '(avy company consult embark embark-consult magit marginalia orderless
	 rust-mode vertico wgrep zig-mode)))
(custom-set-faces)
(set-frame-font "-outline-Typestar OCR-medium-normal-normal-*-*-*-*-*-c-*-iso10646-1" nil t)
(menu-bar-mode 0)
(when (display-graphic-p)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (set-fringe-mode 0))
(setq inhibit-startup-screen t)
(global-set-key (kbd "C-,") 'avy-goto-char-2)
(which-key-mode 1)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq lazy-count-suffix-format nil)
(add-hook 'after-init-hook 'global-company-mode)
(setq search-whitespace-regexp ".*?")
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

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))
