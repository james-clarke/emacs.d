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

;; why is this not the default??
(setq-default truncate-lines t)

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
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;; must have
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

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
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-banner-logo-title "james-clarke's emacs config: github.com/james-clarke/emacs.d")
  (setq dashboard-startup-banner "~/Pictures/pp-small.png")
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents   . 5)
			  (bookmarks . 5)
			  (projects  . 5)))
  (setq dashboard-icon-type 'all-the-icons)
  (dashboard-setup-startup-hook))

;; file explorer
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode 'always)
  (when treemacs-python-executable
    (treemacs-git-commit-diff-mode t))
  (pcase (cons (not (null (executable-find "git")))
               (not (null treemacs-python-executable)))
    (`(t . t)
     (treemacs-git-mode 'deferred))
    (`(t . _)
     (treemacs-git-mode 'simple)))
  (treemacs-hide-gitignored-files-mode nil)
  :bind (:map global-map
	      ("M-0"       . treemacs-select-window)
	      ("C-x t 1"   . treemacs-delete-other-windows)
	      ("C-x t t"   . treemacs)
	      ("C-x t d"   . treemacs-select-directory)
	      ("C-x t B"   . treemacs-bookmark)
	      ("C-x t C-t" . treemacs-find-file)
	      ("C-x t M-t" . treemacs-find-tag)))

;; treemacs integrations
(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)
(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)
(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

;; essential for working with git
(use-package magit
  :ensure t)
