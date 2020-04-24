(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)user-emacs-directory)
        ((boundp 'user-init-directory)user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))


(load-user-file "platform.el")
(load-user-file "packages.el")
(load-user-file "general.el")
(load-user-file "openscad.el")
(load-user-file "c++.el")
(load-user-file "python.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (jedi zygospore use-package solarized-theme scad-preview company-jedi company-irony))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
