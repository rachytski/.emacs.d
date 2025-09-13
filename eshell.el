;;; eshell completions behaviour customization

(defun rachytski-eshell-completions-hook ()
   (setq company-require-match 'never))

(add-hook 'eshell-mode-hook 'rachytski-eshell-completions-hook)

(setq eshell-cmpl-cycle-completions nil)
