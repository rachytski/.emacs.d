;;; Using Emacs in terminal requires special way of sending some key combinations.
;;; In particular, terminal emulators can't send correctly some combinations, like C-. C-,
;;; Instead some terminals may be configured to send escape sequences, which will be

;;; recognized as aforementioned key combinations by term-keys package and forwarded
;;; for processing to Emacs. Not all terminals support such customization of sending
;; custom escape sequences, refer to term-keys documentation to figure out which do.

(use-package term-keys
  :ensure t
  :init (term-keys-mode t))

(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "M-p") 'scroll-down)

;;(global-set-key (kbd "M-m") 'toggle-frame-maximized)

; remove annoying behaviour of destroying windows layout on triple-ESC 
(defadvice keyboard-escape-quit
  (around keyboard-escape-quit-dont-close-windows activate)
  (let ((buffer-quit-function (lambda () ())))
    ad-do-it))
