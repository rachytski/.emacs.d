(use-package ivy
  :ensure t)

(use-package projectile
  :ensure t
  :bind (("C-," . 'projectile-find-other-file)
         ("C-x p" . 'projectile-command-map))
  :config
    (setq projectile-completion-system 'ivy)
    (projectile-mode +1))
