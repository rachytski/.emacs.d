;(use-package lsp-python-ms
;  :ensure t
;  :init
;  (setq lsp-python-ms-auto-install-server t)
;  :hook
;  (python-mode . (lambda ()
;                   (require 'lsp-python-ms)
;                   (lsp))))

(use-package yapfify
  :ensure t
  :config
  ;;(print "Configuring YAPF")
  :hook
  (python-mode . yapf-mode))

