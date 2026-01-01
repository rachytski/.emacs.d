;; Using same way to configure Emacs settings as for other packages
(use-package
 emacs
 :init
 (message "Initializing common Emacs settings")
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
 (setq-default
  indent-tabs-mode nil
  tab-width 2)
 :config (message "Configuring common Emacs settings")
 ;; Windmove binding for quick windows navigation
 ;; (WASD-style but with IJKL)
 (global-set-key (kbd "C-M-j") 'windmove-left)
 (global-set-key (kbd "C-M-l") 'windmove-right)
 (global-set-key (kbd "C-M-i") 'windmove-up)
 (global-set-key (kbd "C-M-k") 'windmove-down)
 ;; Window size management
 (global-set-key (kbd "C-M-S-j") 'shrink-window-horizontally)
 (global-set-key (kbd "C-M-S-l") 'enlarge-window-horizontally)
 (global-set-key (kbd "C-M-S-i") 'shrink-window)
 (global-set-key (kbd "C-M-S-k") 'enlarge-window)
 ;; Scrolling  
 (global-set-key (kbd "C-M-n") 'scroll-up)
 (global-set-key (kbd "C-M-p") 'scroll-down)
 ;; List of usefull shortcuts
 ;; For ELisp code
 ;; C-M-e - go to previous outermost (
 ;; C-M-a - go to next outermost )
 ;;(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
 ;;(global-set-key (kbd "M-m") 'toggle-frame-maximized)
 ;;(global-set-key (kbd "C-<tab>") `next-buffer)
 ;; remove annoying behaviour of destroying windows layout on triple-ESC 
 (defadvice keyboard-escape-quit
     (around keyboard-escape-quit-dont-close-windows activate)
   (let ((buffer-quit-function (lambda () ())))
     ad-do-it)))
