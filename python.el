(use-package lsp-python-ms
  :ensure t
  :init
  (setq lsp-python-ms-auto-install-server t)
  :hook
  (python-mode . (lambda ()
                   (require 'lsp-python-ms)
                   (lsp))))


