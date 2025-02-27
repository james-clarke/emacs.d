;;; init.el --- -*- lexical-binding: t -*-

;;; Commentary:


;;; Code:


;; load in custom file to begin
(setq custom-file "~/.config/emacs-custom.el")
(load custom-file)

;; stop generation of auto-save-list directory
(setq auto-save-list-file-prefix nil)
(setq auto-save-file-name-transforms nil)

;; stop generation of backup files
(setq make-backup-files nil)
(setq backup-directory-alist nil)

;; make re-sizing fit to exact pixel (wm fix)
(setq frame-resize-pixelwise t)

;; remove start-up screen
(setq inhibit-startup-screen t)

;; cursor movement
(global-set-key (kbd "s-<up>") #'beginning-of-buffer)
(global-set-key (kbd "s-<down>") #'end-of-buffer)

;; specify starting window size:
(add-to-list 'default-frame-alist '(width . 105))
(add-to-list 'default-frame-alist '(height . 45))

;; font
(add-to-list 'default-frame-alist '(font . "SFMono Nerd Font-16"))

;; add line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; why is this not the default??
(setq-default truncate-lines t)

;; vim-like scrolloff
(setq scroll-step   1)
(setq scroll-margin 10)

;; set up melpa for newer packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; helps learn emacs specific bindings
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (which-key-setup-minibuffer)
  (setq which-key-idle-delay 0.1))

;; trying this theme out for a lil
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

;; good selection framework for projectile
(use-package vertico
  :ensure t
  :init
  (vertico-mode +1))

;; super useful project navigation
(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/Developer/"))
  :config
  (projectile-mode +1)
  (projectile-discover-projects-in-search-path)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))

;; icons
(use-package nerd-icons
  :ensure t)
(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; essential for working with git
(use-package magit
  :ensure t)

;; mini map
(use-package demap
  :ensure t)

;; auto-completion framework
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; code snippets
(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

;; snippit collection for yas
(use-package yasnippet-snippets
  :ensure t)

;; basic syntax checking
(use-package flycheck
  :ensure t
  :hook
  (prog-mode . flycheck-mode))

;; for previewing markdown files
(use-package markdown-mode
  :ensure t
  :mode
  ("README\\.md\\'" . gfm-mode)
  :init
  (setq markdown-command "multimarkdown"))

;; handling automatic ts-mode
(add-to-list 'major-mode-remap-alist
	     '(python-mode . python-ts-mode))

(add-to-list 'major-mode-remap-alist
	     '(c-mode . c-ts-mode))




(provide 'init)
;;; init.el ends here.
