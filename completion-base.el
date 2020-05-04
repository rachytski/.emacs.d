(setq-default c-default-style "bsd" c-basic-offset 2)

(use-package company
  :ensure t
  :init
  (global-company-mode)
  (setq company-idle-delay 0)
  :bind (("C-/" . company-complete-common-or-cycle)
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ("C-h" . delete-backward-char))
  :config
  (unbind-key "M-n" company-active-map)
  (unbind-key "M-p" company-active-map)
  (delete `company-clang company-backends)
  )



