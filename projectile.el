(use-package projectile
  :ensure t
  :bind (("C-," . 'projectile-find-other-file)
         ("C-x p" . 'projectile-command-map)
         ("<C-tab>" . 'projectile-find-file))
  :config
    (setq projectile-completion-system 'ivy)
    (projectile-mode +1))
