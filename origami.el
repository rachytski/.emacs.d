(use-package origami :ensure t)
(use-package lsp-origami :ensure t)
(add-hook 'lsp-after-open-hook 'lsp-origami-try-enable)
