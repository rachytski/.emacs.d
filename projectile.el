(use-package ivy
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-,") 'projectile-find-other-file)
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))
