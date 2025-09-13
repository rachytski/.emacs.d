(defun rachytski-find-project-root (name)
  (progn
  (message (format "figuring projectile project root for '%s'" name))
  (let* ((project-root (seq-find (lambda (elem) (string-suffix-p (concat name "/") elem)) projectile-known-projects)))
    (progn (message (format "found projectile project root '%s'" project-root))
	   project-root))
  ))

(defun hide-treemacs () (treemacs))

(use-package treemacs
  :ensure t
  :requires
  (perspective projectile)
  :config
  (add-hook 'projectile-after-switch-project-hook
	    (lambda ()
	      (progn
		(message "before displaying exclusively")
		(treemacs-display-current-project-exclusively)
		(message "projectile-after-switch-project-hook"))
	      )
	    )
  (setq perspectives-loaded nil)
  (add-hook 'persp-before-switch-hook
	    (lambda () (if perspectives-loaded (hide-treemacs))))
  (add-hook 'persp-switch-hook
	    (lambda () (let* ((name (persp-current-name))
			      (project-root (rachytski-find-project-root name)))
			 (if perspectives-loaded
			     (if project-root
				 (progn
				   (message (format "persp-switch-hook: making treemacs show project '%s'" name))
				   (treemacs--show-single-project project-root name)
				   )
			       (message (format "persp-switch-hook: no project root for '%s'" name)))
			     (message "persp-switch-hook: inside perspectives loading code")
			   ))
	      )
	    )
  )

(use-package treemacs-projectile
  :ensure t
  :requires
  (projectile treemacs)
  :init
  (require 'treemacs-projectile)
  )

(use-package treemacs-perspective
  :ensure t
  :requires
  (perspective treemacs)
  :init
  (require 'treemacs-perspective)
  )
