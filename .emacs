;;; -*- lexical-binding: t -*-
(menu-bar-mode 0)
(savehist-mode 1)
(electric-pair-mode 1)
(delete-selection-mode 1)
(which-function-mode)
(editorconfig-mode)
(load-theme 'modus-vivendi t)
(column-number-mode 1)
(setopt treesit-font-lock-level 4)
(when (display-graphic-p)
  (set-cursor-color "yellow")
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (set-fringe-mode 0))
(defun move-text-internal (arg)
    (cond
     ((and mark-active transient-mark-mode)
      (if (> (point) (mark))
             (exchange-point-and-mark))
      (let ((column (current-column))
               (text (delete-and-extract-region (point) (mark))))
        (forward-line arg)
        (move-to-column column t)
        (set-mark (point))
        (insert text)
        (exchange-point-and-mark)
        (setq deactivate-mark nil)))
     (t
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
             (transpose-lines arg))
        (forward-line -1)))))
 
(defun move-text-down (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines down."
   (interactive "*p")
   (move-text-internal arg))

(defun move-text-up (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines up."
   (interactive "*p")
   (move-text-internal (- arg)))

(global-set-key (kbd "C-<up>") 'move-text-up)
(global-set-key (kbd "C-<down>") 'move-text-down)
(global-set-key (kbd "C-c C-v") 'duplicate-dwim)
(global-set-key (kbd "M-Z") 'zap-up-to-char)
(setq inhibit-startup-screen t)
(setq imenu-flatten t)
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
(use-package treesit-auto ;; package-vc-install RET https://github.com/renzmann/treesit-auto.git RET
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
(use-package markdown-mode :ensure t)
(use-package rust-mode :ensure t)
(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package rainbow-mode :ensure t)
(use-package zig-mode :ensure t)
(use-package magit :ensure t)
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
(defadvice vc-git-mode-line-string (after plus-minus (file) compile activate)
  (setq ad-return-value
    (concat ad-return-value
            (let ((plus-minus (vc-git--run-command-string
                               file "diff" "--numstat" "--")))
              (and plus-minus
                   (string-match "^\\([0-9]+\\)\t\\([0-9]+\\)\t" plus-minus)
                   (format " +%s-%s" (match-string 1 plus-minus) (match-string 2 plus-minus)))))))
(custom-set-faces
 '(font-lock-number-face ((t (:foreground "brightred"))))
 '(font-lock-property-name-face ((t (:foreground "chocolate"))))
 '(font-lock-property-use-face ((t (:foreground "chocolate"))))
 '(font-lock-variable-name-face ((t (:foreground "skyblue")))))

