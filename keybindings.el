;;; Using Emacs in terminal requires special way of sending some key combinations.
;;; In particular, terminal emulators can't send correctly some combinations, like C-. C-,
;;; Instead some terminals may be configured to send escape sequences, which will be
;;; recognized as aforementioned key combinations by term-keys package and forwarded
;;; for processing to Emacs. Not all terminals support such customization of sending
;; custom escape sequences, refer to term-keys documentation to figure out which do.

(defun custom/write-xterm-config ()
  (require 'term-keys-xterm)
  (with-temp-buffer
    (insert (term-keys/xterm-xresources))
    (append-to-file (point-min) (point-max) "~/.Xresources")))

(use-package
 term-keys
 :ensure t
 :init (term-keys-mode t)
 :config (message "Configuring term-keys")
 ;; (custom/write-xterm-config)
 )
