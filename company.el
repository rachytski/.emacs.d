(use-package
 company
 :ensure t
 :init (global-company-mode)
 :bind
 ( ;;;("C-/" . company-complete-common-or-cycle)
  :map
  company-active-map
  ("C-n" . company-select-next)
  ("C-p" . company-select-previous)
  ("C-h" . delete-backward-char))
 :config
 (unbind-key "M-n" company-active-map)
 (unbind-key "M-p" company-active-map)
 (delete `company-clang company-backends)
 :custom
 (company-minimum-prefix-length 2)
 (company-idle-delay 0.0))
