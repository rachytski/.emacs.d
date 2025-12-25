;;; eshell completions behaviour customization

(defun custom/eshell-completions-hook ()
   (setq company-require-match 'never))

(add-hook 'eshell-mode-hook 'custom/eshell-completions-hook)

(setq eshell-cmpl-cycle-completions nil)
