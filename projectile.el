(use-package ivy
  :ensure t)

(use-package projectile
  :ensure t
  :bind (("C-," . 'projectile-find-other-file)
         ("C-x p" . 'projectile-command-map))
         ;("<C-tab>" . 'projectile-find-file))
  :config
    (setq projectile-completion-system 'ivy)
    (projectile-mode +1))

(use-package helm-projectile
  :ensure t
  :bind (("<C-tab>" . 'helm-projectile-find-file)
         ("C-x o" . 'helm-projectile-switch-project)))
