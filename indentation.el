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


(use-package
 elisp-autofmt
 :ensure t
 :hook (emacs-lisp-mode . elisp-autofmt-mode)
 :init
 (setq elisp-autofmt-cache-directory
       `,(user-cache-path "elisp-autofmt-cache"))
 :config (setf elisp-autofmt-on-save-p (lambda () 'always)))
