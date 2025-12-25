(use-package clang-format
  :ensure t
  :commands
  (clang-format-buffer clang-format-on-save-mode)
  :hook
  ((c-mode c++-mode) . clang-format-on-save-mode)
  :config
  (clang-format-on-save-mode)
  (fset 'c-indent-region 'clang-format-region) 
  )


