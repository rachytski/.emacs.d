(require 'cl-lib)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-check-signature nil)
(setq package-user-dir elpa-personal-path)
(package-initialize)

(defvar personal-selected-packages '(use-package)
  "crucial packages to run the rest of configuration")

(defun personal-packages-installed-p ()
  (cl-loop for pkg in personal-selected-packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (personal-packages-installed-p)
  (message "%s" "refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg personal-selected-packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))
