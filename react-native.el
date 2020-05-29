(use-package nvm
  :ensure t)

(use-package add-node-modules-path
  :ensure t
  :hook (web-mode . 'add-node-modules-path))

(defun rachytski/activate-tide-mode ()
  "using hl-identifier mode for js buffers"
  (when (and (stringp buffer-file-name)
             (string-match "\\.jsx?\\'" buffer-file-name))
    (tide-setup)
    (tide-hl-identifier-mode)))

(use-package web-mode
  :ensure t
  :mode
  ("\\.html\\'" "\\.jsx?\\'")
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
  (setq web-mode-content-types-alist '(("jsx" . "\\.jsx?\\'"))
        web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-script-padding 2
        web-mode-block-padding 2
        web-mode-style-padding 2
        web-mode-enable-auto-pairing t
        web-mode-enable-auto-closing t
        web-mode-enable-current-element-highlight t
        js-indent-level 2)
  )

(use-package tide
  :ensure t
  :hook (web-mode . rachytski/activate-tide-mode))


