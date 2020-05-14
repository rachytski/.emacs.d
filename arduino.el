(use-package company-arduino
  :ensure t
  :config (add-to-list 'company-backends 'company-arduino))

(use-package arduino-mode
  :ensure t
  :mode "\\.ino$"
  :config
  (add-hook 'c++-mode-hook (lambda ()
                             (lsp))))



