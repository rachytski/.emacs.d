;; Install LSP-server for go first
;; One option is to use gopls
;; read installation instruction here
;; https://github.com/golang/tools/blob/master/gopls/doc/user.md
;; NB: Make sure gopls is on the PATH for
;; lsp-mode to pick it up automatically

(use-package go-mode
  :ensure t
  :hook((go-mode . (lambda () (require 'go-mode) (lsp)))))

  


