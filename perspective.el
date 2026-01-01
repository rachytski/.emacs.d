;; Perspectives management.
;;
;; Save/restore windows layout when switching projects
;;

(use-package
 perspective
 :ensure t
 :custom (persp-suppress-no-prefix-key-warning t)
 ;  (persp-mode-prefix-key (kbd "C-x l"))
 (persp-state-default-file (user-cache-path ".perspectives"))
 :init
 (setq switch-to-prev-buffer-skip
       (lambda (win buff bury-or-kill)
         (not (persp-is-current-buffer buff))))
 (persp-mode)
 :config
 (message "Configuring Perspective Package")
 (setq perspectives-loaded nil)
 (if (file-exists-p persp-state-default-file)
     (persp-state-load persp-state-default-file))
 (setq perspectives-loaded t)
 :custom
 (persp-modestring-short t)
 (persp-purge-initial-persp-on-save t))

(use-package
 persp-projectile
 :ensure t
 :init (require 'persp-projectile)
 :requires (projectile perspective))
