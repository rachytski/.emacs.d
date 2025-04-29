(use-package dired-sidebar
  :ensure t
  :bind (("C-x C-d" . dired-sidebar-toggle-sidebar)
         )
  :commands (dired-sidebar-toggle-sidebar)
  :init (add-hook 'dired-sidebar-mode-hook (lambda () (unless (file-remote-p default-directory) (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (setq dired-sidebar-subtree-line-prefix "--")
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t)
  )
