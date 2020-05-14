(use-package ccls
  :ensure t
  :init(setq ccls-executable (expand-file-name "builds/ccls/ccls" elpa-personal-path))
  :hook((c-mode c++-mode) . (lambda () (require `ccls) (lsp))))
  :config
  `(ccls-initialization-options (quote(compilationDatabaseDirectory :build)))


