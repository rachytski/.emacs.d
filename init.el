;;; package --- SIR .emacs settings
;;; Commentary: 
;;; Code:

(setq clang-full-path "C:\\Compilers\\LLVM-9.0.0\\bin\\clang.exe")
(setq scad-full-path "C:\\Tools\\OpenSCAD\\openscad.exe")

; Here is where all the installed packages go.
; For this task home-based directory is prefferable, unless:
; 1. you're on Windows
; 2. using native Emacs build,
; 3. and your username contains non-ASCII symbols.
; (which is BTW usefull for debugging Unicode support here and there)
(setq elpa-personal-path "F:\\Projects\\elpa-personal")

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
(setq package-user-dir elpa-personal-path)
(package-initialize)

; zygospore package is a lifesaver!
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)

; LLVM clang.exe path to support C++ autocompletion
(setq company-clang-executable clang-full-path)
(setq company-idle-delay 0)

(use-package irony
  :ensure t
  :config
  (use-package company-irony
    :ensure t
    :config
    (add-to-list 'company-backends 'company-irony))
  (add-hook 'c++-mode-hook `irony-mode)
  (add-hook 'c-mode-hook `irony-mode)
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map[remap completion-at-point] `irony-completion-at-point-async)
    (define-key irony-mode-map[remap complete-symbol] `irony-completion-at-point-async))
  (add-hook `irony-mode-hook `my-irony-mode-hook)
  (add-hook `irony-mode-hook `irony-cdb-autosetup-compile-options)
)

(use-package company
  :ensure t
  :init
  (global-company-mode)
  :bind (("C-/" . company-complete-common-or-cycle)
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ("C-h" . delete-backward-char))
  :config
  (unbind-key "M-n" company-active-map)
  (unbind-key "M-p" company-active-map)
)

(require 'irony)
;; irony package settings
;; Windows performance tweaks
;; from https://github.com/Sarcasm/irony-mode
(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))
;; Set the buffer size to 64K on Windows (from the original 4K)
(when (boundp 'w32-pipe-buffer-size)
  (setq irony-server-w32-pipe-buffer-size (* 64 1024)))

; activate 'company' mode after initialization
(add-hook `after-init-hook `global-company-mode)

(add-to-list 'company-backends 'company-jedi 'company-irony)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(inhibit-startup-screen t)
 '(irony-extra-cmake-args
   (quote
    ("-G" "Visual Studio 14 2015 Win64" "-DCMAKE_PREFIX_PATH=c:/Compilers/LLVM-9.0.0" "-DCLANG_RESOURCE_DIR=c:/Compilers/LLVM-9.0.0/lib/clang/9.0.0")))
 '(irony-server-install-prefix "F:\\Projects\\elpa-personal\\builds\\irony")
 '(package-selected-packages
   (quote
    (company-irony zygospore use-package company jedi company-jedi scad-preview scad-mode)))
 '(scad-command scad-full-path)
 '(scad-preview-image-size (quote (1600 . 1800))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
