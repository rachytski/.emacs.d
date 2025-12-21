(defun rachytski-find-project-root (name)
  (progn
  (message (format "figuring projectile project root for '%s'" name))
  (let* ((project-root (seq-find (lambda (elem) (string-suffix-p (concat name "/") elem)) projectile-known-projects)))
    (progn (message (format "found projectile project root '%s'" project-root))
	   project-root))
  ))

(defun rachytski-hide-treemacs () (delete-window (treemacs-get-local-window)))

(defun rachytski-show-single-project (project-root name)
  (progn
    (message "persp-switch-hook: making treemacs show project '%s' with root '%s'" name project-root)
    (treemacs--show-single-project project-root name)))


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
	    (lambda () (if perspectives-loaded (progn (message "persp-before-switch-hook: hiding treemacs")(rachytski-hide-treemacs)))))
  (add-hook 'persp-switch-hook
	    (lambda () (let* ((name (persp-current-name))
			      (project-root (rachytski-find-project-root name)))
			 (if perspectives-loaded
			     (if project-root
				 (rachytski-show-single-project (expand-file-name project-root) name)
			       (message (format "persp-switch-hook: no project root for '%s'" name)))
			     (message "persp-switch-hook: inside perspectives loading code")
			   ))
	      )
	    )
  :custom
  (treemacs-persist-file (expand-file-name "treemacs-persist" user-cache-dir))
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
