;;; init.el --- -*- lexical-binding: t -*-

;; This file loads before package and UI initialization happens.
;; Helps to reduce start-up time and offers some interesting perfomance benefits.
;; Credit: https://github.com/MatthewZMD/.emacs.d

;; Defer garbage collection
(setq gc-cons-threshold 100000000)

;; Disable package initialization at start up
(setq package-enable-at-startup nil)

;; Don't need any of these
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Diable site-run-file
(setq site-run-file nil)

;; Disable unnecessary interface
(menu-bar-mode -1)
(unless (and (display-graphic-p) (eq system-type 'darwin))
  (push '(menu-bar-lines . 0) default-frame-alist))
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
