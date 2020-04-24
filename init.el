(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)user-emacs-directory)
        ((boundp 'user-init-directory)user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(setq custom-file (expand-file-name "custom.el" user-init-dir))
      
(load-user-file "platform.el")
(load-user-file "packages.el")
(load-user-file "general.el")
(load-user-file "openscad.el")
(load-user-file "c++.el")
(load-user-file "python.el")
