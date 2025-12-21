;;; Redirecting all emacs caches to user-cache-dir

(defun ensure-directory (root &optional entry)
  (let ((full-path (if entry (expand-file-name entry root) root)))
    (unless (file-exists-p full-path) (make-directory full-path))
    full-path))

(defun user-cache-path (subpath) (expand-file-name subpath user-cache-dir))

(ensure-directory user-cache-dir)
(ensure-directory user-cache-dir "transient")

(setq backups-dir (ensure-directory user-cache-dir ".backups"))
(setq autosaves-dir (ensure-directory user-cache-dir ".autosaves"))

(setq transient-history-file (user-cache-path "transient/history.el"))
(setq eshell-directory-name (ensure-directory user-cache-dir "eshell"))

(when (boundp 'native-comp-eln-load-path)
  (startup-redirect-eln-cache (user-cache-path "eln-cache")))

(setq org-persist-directory (user-cache-path "org-persist"))

; Storing all backups in a separate dir
(setq backup-by-copying t ; copy, don't symlink
      backup-directory-alist `(("." . ,backups-dir))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
; Storing all autosaves in a separate dir
(setq auto-save-file-name-transforms `((".*" ,autosaves-dir t)))
; Custom prefix for auto-save-list 
(setq auto-save-list-file-prefix (user-cache-path "auto-save-list"))

(setq package-user-dir (user-cache-path "elpa-mirror"))

(setq lsp-session-file (user-cache-path ".lsp-session-v1"))

(setq projectile-known-projects-file (user-cache-path "projectile-bookmarks.eld"))

