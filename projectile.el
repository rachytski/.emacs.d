;; Project management

(defun custom/find-project-root (name)
  (message "figuring projectile project root for '%s'" name)
  (let* ((project-root (seq-find (lambda (elem) (string-suffix-p (concat name "/") elem)) projectile-known-projects)))
    (progn
      (message "found projectile project root '%s'" project-root)
	    project-root))
  )

(use-package projectile
  :ensure t
  :bind (("C-," . 'projectile-find-other-file)
         ("C-x p" . 'projectile-command-map)
         ("M-m" . 'projectile-find-file))
  :config
  (projectile-mode +1)
  (projectile-update-project-type 'cmake :precedence 'high)
  :custom
  (projectile-completion-system 'ivy)
  (projectile-enable-cmake-presets t)
  (projectile-dirconfig-comment-prefix "#")
  (nameframe-projectile-mode t)
  )

;; Better buffers switching
;; Breaks on switching to some buffers like *Messages*,
;; so filtering them out with regexp 
(use-package nswbuff
  :ensure t
  :requires
  (projectile)
  :config
  (global-set-key (kbd "C-<tab>") 'nswbuff-switch-to-next-buffer)
  (global-set-key (kbd "C-M-<tab>") 'nswbuff-switch-to-previous-buffer)  
  (setq nswbuff-display-intermediate-buffers t)
  (setq nswbuff-buffer-list-function 'nswbuff-projectile-buffer-list)
  :custom
  (nswbuff-exclude-buffer-regexps '("^magit.*" "^ " "^\*.*\*").)
  )

(use-package counsel-projectile
  :ensure t
  :requires
  (projectile counsel))

(use-package projectile-codesearch
  :ensure t
  :requires
  (projectile))
