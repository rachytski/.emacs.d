;; Using same way to configure Emacs settings as for other packages
(use-package emacs
  :init
  (setq normal-erase-is-backspace-mode 1)
  ;; C-h adds less wrist strain than backspace.  
  (global-set-key (kbd "C-h") 'delete-backward-char)
  (global-set-key (kbd "C-?") 'help-command)
  ;; No startup screen, go straight to the point
  (setq inhibit-startup-screen t)
  (cua-mode t)
  ;; Switching off parts of interface for lean-and-clean look 
  ;;(scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (show-paren-mode t)
  ;; make compilation buffer to follow-scrolling output until error occures
  (setq compilation-scroll-output 'first-error)
  ;; by default indent with spaces, tab size is 2 spaces
  (setq-default indent-tabs-mode nil
	              tab-width 2)
)
