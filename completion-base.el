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

(use-package markdown-mode
  :ensure t)

(use-package lsp-mode
  :ensure t
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company-lsp
  :ensure t
  :commands company-lsp)


