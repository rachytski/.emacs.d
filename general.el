;; Allows emacs to inherit parent shell environment,
;; instead of using system-wide ones
(use-package exec-path-from-shell
  :ensure t)

;; Allows mission-control-like switching between emacs buffers
;; Initiate with Ctrl-Tab, continue switching with Tab.
;; Note, that Ctrl-I is the same as Tab, so switching is
;; eeringly similar to Visual Studio tab switching behaviour
;; (which is the goal btw, as its super convenient)
;(use-package buffer-expose
;  :ensure t
;  :bind(("<C-tab>" . buffer-expose-no-stars))
;  )

;; Interface to 'The Silver Searcher'
;; https://github.com/ggreer/the_silver_searcher
;; Windows: install ag using chocolatey package manager
;; Other: use native package managers
(use-package ag
  :ensure t)

;; Shows completion for the currently entered partial key
;; https://github.com/justbur/emacs-which-key
(use-package which-key
  :ensure t
  :config (which-key-mode))

(unless (file-exists-p "~/.emacs.d/.backups/") (make-directory "~/.emacs.d/.backups/") )
(unless (file-exists-p "~/.emacs.d/.autosaves/") (make-directory "~/.emacs.d/.autosaves/") )

; Storing all backups in a separate dir
(setq backup-by-copying t ; copy, don't symlink
      backup-directory-alist `(("." . "~/.emacs.d/.backups/"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
; Storing all autosaves in a separate dir
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/.autosaves/" t)))

(normal-erase-is-backspace-mode 1)
; C-h adds less wrist strain than backspace.
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-?") 'help-command)

;; No startup screen, go straight to the point
(setq inhibit-startup-screen t)
(cua-mode t)

;; Switching off parts of interface for lean-and-clean look 
;(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode t)

;; zygospore package is a lifesaver!
(use-package zygospore
  :ensure t
  :bind(("C-x 1" . 'zygospore-toggle-delete-other-windows))
  )
