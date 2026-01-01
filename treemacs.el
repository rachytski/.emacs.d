(defun custom/hide-treemacs ()
  (let* ((elapsed
          (benchmark-elapse
           (delete-window (treemacs-get-local-window)))))
    (message
     "persp-before-switch-hook: hiding treemacs took '%f' seconds"
     elapsed)))

(defun custom/show-single-project (project-root name)
  (let* ((elapsed
          (benchmark-elapse
           (treemacs--show-single-project project-root name))))
    (message
     "persp-switch-hook: making treemacs show project '%s' with root '%s' took '%f' seconds"
     name project-root elapsed)))

(use-package
 treemacs
 :ensure t
 :config (treemacs-follow-mode)
 :custom (treemacs-persist-file (user-cache-path "treemacs-persist"))
 (treemacs-last-error-persist-file
  (user-cache-path "treemacs-persist-at-last-error")))

(use-package
 treemacs-projectile
 :ensure t
 :requires (projectile treemacs)
 :init (require 'treemacs-projectile)
 :hook
 (projectile-after-switch-project
  .
  (lambda ()
    (progn
      (message "displaying project exclusively took '%f' seconds"
               (benchmark-elapse
                (treemacs-display-current-project-exclusively)))
      (message "projectile-after-switch-project-hook")))))

(use-package
 treemacs-perspective
 :ensure t
 :requires (perspective treemacs)
 :init (require 'treemacs-perspective)
 :config (treemacs-display-current-project-exclusively)
 :hook
 (persp-before-switch
  .
  (lambda ()
    (if perspectives-loaded
        (custom/hide-treemacs))))
 (persp-switch
  .
  (lambda ()
    (let* ((name (persp-current-name))
           (project-root (custom/find-project-root name)))
      (if perspectives-loaded
          (if project-root
              (custom/show-single-project
               (expand-file-name project-root) name)
            (message
             "persp-switch-hook: no project root for '%s' project"
             name))
        (message
         "persp-switch-hook: inside perspectives loading code")))))
 (kill-emacs
  .
  (lambda ()
    (progn
      (custom/hide-treemacs)
      (persp-state-save)))))
