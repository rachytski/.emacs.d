;;; package --- SIR .emacs settings
;;; Commentary: 
;;; Code:

(unless (file-exists-p "~/.emacs.d/.backups/") (make-directory "~/.emacs.d/.backups/") )
(unless (file-exists-p "~/.emacs.d/.autosaves/") (make-directory "~/.emacs.d/.autosaves/") )

; storing all backups in a separate dir
(setq backup-by-copying t ; copy, don't symlink
      backup-directory-alist `(("." . "~/.emacs.d/.backups/"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
; storing all autosaves in a separate dir
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/.autosaves/" t)))

(setq-default
  c-default-style "bsd"
  c-basic-offset 2
  )
; tab width is 2 spaces
(setq-default tab-width 2)
; indenting with spaces
(setq-default indent-tabs-mode nil)
(normal-erase-is-backspace-mode 1)
; C-h is faster than backspace
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-?") 'help-command)

(require `package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-check-signature nil)
(package-initialize)

; autocompletion support through "company" package
(require `company)
; global shortcuts
(global-set-key (kbd "C-/") 'company-complete-common-or-cycle)

; remapping non-obvious 'company' choice of next/prev symbol in completion window
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

; LLVM clang.exe path to support C++ autocompletion
(setq company-clang-executable "C:\\Tools\\LLVM\\bin\\clang.exe")

; activate 'company' mode after initialization
(add-hook `after-init-hook `global-company-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
	 (quote
		(company company-clang flycheck flycheck-irony scad-preview scad-mode)))
 '(scad-command "C:\\Tools\\OpenSCAD\\openscad.exe")
 '(scad-preview-image-size (quote (1600 . 1800)))
)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
