;(package-initialize)

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
(load-user-file "keybindings.el")
(load-user-file "packages.el")
(load-user-file "helm.el")
(load-user-file "projectile.el")
(load-user-file "magit.el")
(load-user-file "colors.el")
(load-user-file "general.el")
(load-user-file "react-native.el")
(load-user-file "openscad.el")
(load-user-file "indentation.el")
(load-user-file "company.el")
(load-user-file "lsp.el")
(load-user-file "ccls.el")
(load-user-file "go.el")
;(load-user-file "c++-irony.el")
;(load-user-file "python.el")
(load-user-file "arduino.el")
(load-user-file "platformio.el")
(load-user-file "custom.el")
