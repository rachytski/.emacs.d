(use-package projectile
  :ensure t
  :bind (("C-," . 'projectile-find-other-file)
         ("C-x p" . 'projectile-command-map)
         ("M-m" . 'projectile-find-file))
  :config
  (projectile-mode +1)
  :custom
  (projectile-completion-system 'ivy)
  (projectile-dirconfig-comment-prefix "#")
  (nameframe-projectile-mode t)
  )

(use-package persp-projectile
  :ensure t
  :requires
  projectile
  )

(use-package perspective
  :ensure t
  :custom
  (persp-mode-prefix-key (kbd "C-x l"))
  (persp-state-default-file (expand-file-name ".perspectives" user-cache-dir))
  :requires
  persp-projectile
  :init
  (setq switch-to-prev-buffer-skip
	(lambda (win buff bury-or-kill)
	  (not (persp-is-current-buffer buff))
	  )
	)
  (add-hook 'kill-emacs-hook 
	    (lambda ()
	      (progn
		(treemacs)
		(persp-state-save))
	      )
	    )
  (persp-mode)
  (require 'persp-projectile)
  :config
  (message "Configuring Perspective Package")
  :custom
  (persp-modestring-short t)
  (persp-purge-initial-persp-on-save t)
  )


