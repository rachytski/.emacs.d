(use-package ccls
  :ensure t
  :init(setq ccls-executable "f:/Projects/ccls/build/Release/MinSizeRel/ccls.exe")
  :hook((c-mode c++-mode) . (lambda () (require `ccls) (lsp))))


