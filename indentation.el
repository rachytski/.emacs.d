;(setq-default c-default-style "bsd"
;              c-basic-offset 2 ; base structural offset is 2 spaces
;              indent-tabs-mode nil ; indenting with spaces
;              tab-width 2 ; tab width is 2 spaces
;              )

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

(setq tab-width 2)


