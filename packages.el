(require 'cl)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-check-signature nil)
(setq package-user-dir elpa-personal-path)
(package-initialize)

(defvar my-selected-packages '(solarized-theme
                               use-package                               
                               company                               
                               company-irony
                               jedi
                               company-jedi
                               scad-preview
                               scad-mode)
  "default packages")

(defun my-packages-installed-p ()
  (loop for pkg in my-selected-packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (my-packages-installed-p)
  (message "%s" "refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg my-selected-packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

