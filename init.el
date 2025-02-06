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

;; ui
(tool-bar-mode    -1)
(scroll-bar-mode  -1)
(tooltip-mode     -1)

;; font
(add-to-list 'default-frame-alist
             '(font . "SFMono Nerd Font-16"))

;; add line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; vim-like scrolloff
(setq scroll-step   1)
(setq scroll-margin 10)

;; set up melpa for newer packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; need my vim keybindings
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

;; provides useful functions for evil
(use-package goto-chg
  :ensure t)

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
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))

;; make it look nice
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
