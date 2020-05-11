(require 'cl-lib)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-check-signature nil)
(setq package-user-dir elpa-personal-path)
(package-initialize)

;; do not auto-install anything else here as other
;; packages are configured through use-package and can
;; auto-install themselves as needed
(defvar personal-selected-packages '(use-package)
  "crucial packages to run the rest of configuration")

(defun personal-packages-installed-p ()
  (cl-loop for pkg in personal-selected-packages
        when (not (package-installed-p pkg)) do (cl-return nil)
        finally (cl-return t)))

(unless (personal-packages-installed-p)
  (message "%s" "refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg personal-selected-packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))
