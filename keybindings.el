(global-set-key (kbd "M-m") 'toggle-frame-maximized)

; remove annoying behaviour of destroying windows layout on triple-ESC 
(defadvice keyboard-escape-quit
  (around keyboard-escape-quit-dont-close-windows activate)
  (let ((buffer-quit-function (lambda () ())))
    ad-do-it))
