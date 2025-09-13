;;; So the idea is to have a local snapshot of installed packages, which should be loaded
;;; almost instantly during Emacs startup, without checking the latest versions online.
;;; From time to time such snapshot should be updateable using elpa-mirror
;;; The latest packages check should be controllable by variable which will be set only
;;; when mirror is updated, in elpa-create-mirror.sh. Otherwise we should just use existing
;;; mirror and doesn't check anything online


(require 'cl-lib)
(require 'package)

;;(setq do-update-local-mirror t)

(add-to-list 'load-path (expand-file-name "elpa-mirror" user-init-dir))
(require 'elpa-mirror)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("cselpa" . "https://elpa.thecybershadow.net/packages/"))

(unless (boundp 'do-update-local-mirror)
  (setq package-archives `(("elpa-mirror" . ,(expand-file-name "elpa-mirror/packages" user-init-dir))))
  )

(print "Enabled ELPA archives:")
(print package-archives)

(setq package-check-signature nil)
(setq package-user-dir (expand-file-name "elpa-cache/packages" user-cache-dir))
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
