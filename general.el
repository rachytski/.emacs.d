(use-package exec-path-from-shell
  :ensure t)

(use-package buffer-expose
  :ensure t
  :bind(("<C-tab>" . buffer-expose-no-stars))
)

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

; tab width is 2 spaces
(setq-default tab-width 2)
; indenting with spaces
(setq-default indent-tabs-mode nil)
(normal-erase-is-backspace-mode 1)
; C-h is faster than backspace
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-?") 'help-command)

(setq inhibit-startup-screen t)
(cua-mode t)

;(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode t)

; zygospore package is a lifesaver!
(use-package zygospore
  :ensure t
  :bind(("C-x 1" . 'zygospore-toggle-delete-other-windows))
  )
