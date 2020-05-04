(use-package ccls
  :ensure t
  :init(setq ccls-executable (expand-file-name "builds/ccls" elpa-personal-path))
  :hook((c-mode c++-mode) . (lambda () (require `ccls) (lsp))))


