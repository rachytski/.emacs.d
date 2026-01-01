;; Config for better full text codebase search in projects and standalone files
;; 
;; Employed here are
;; * RipGrep (which is faster and Windows-usable version of AG)
;; * CodeSearch - index based search tool for huge codebases (like Android AOSP or LLVM)

;; prioritizing codesearch over rg is .csearchindex is present in some parent directory
(defun counsel-codesearch-or-rg ()
  (interactive)
  (if (codesearch--find-dominant-csearchindex default-directory)
      (counsel-codesearch)
    (counsel-rg nil nil nil "Locate(RG):")))

(defun custom/get-buffer-name (text)
  (format "*ivy-occur counsel-codesearch \"%s\"*" text))

(defun custom/async-occur-sentinel (process msg)
  (message "Process %s status changed to %s"
           process
           (string-trim-right msg)))

(defun custom/display-occur-results (buffer-name cands)
  (message "displaying in %s" buffer-name)
  (save-excursion
    (message buffer-name)
    (with-current-buffer (get-buffer-create buffer-name)
      (buffer-disable-undo)
      (delete-region (point-min) (point-max))
      (goto-char (point-min))
      (insert
       (format "-*- mode:grep; default-directory: %S -*-\n\n\n"
               default-directory))
      (insert (format "%d candidates:\n" (length cands)))
      (ivy--occur-insert-lines cands)
      (goto-char (point-min))
      (forward-line 4)))
  )

(defun custom/async-occur-filter (process str)
  (message "inside custom/async-occur-filter, adding %d chars of output" (length str))
  (with-current-buffer (process-buffer process)
    (insert str))
  (when (time-less-p
         (counsel--async-filter-update-time)
         (time-since counsel--async-time))
    (let* ((cands
            (with-current-buffer (process-buffer process)
              (counsel--split-string)))
           (inhibit-read-only t))
      (custom/display-occur-results (custom/get-buffer-name (ivy-state-text ivy-occur-last)) cands)
)))

(defun custom/async-call (command &optional result-fn)
  (message "inside custom/async-call command=%s"
           (string-join command " "))
  (counsel--async-command
   (string-join command " ")
   #'custom/async-occur-sentinel
   #'custom/async-occur-filter
   "*counsel-codesearch-occur*")
  nil)

(defun counsel-codesearch-command (input)
  (list codesearch-csearch "-n" input))

(defun counsel-codesearch-unwind ()
  (counsel-delete-process "*counsel-codesearch*"))

(defun custom/async-grep-like-occur (cmd-template &optional cands)
  (unless (eq major-mode 'ivy-occur-grep-mode)
    (ivy-occur-grep-mode)
    (setq default-directory (ivy-state-directory ivy-last)))
  (ivy-set-text
   (let ((name (buffer-name)))
     (if (string-match "\"\\(.*\\)\"" name)
         (match-string 1 name)
       (ivy-state-text ivy-occur-last))))
  (when cands (custom/display-occur-results (custom/get-buffer-name (ivy-state-text ivy-occur-last))))
  (let* ((cmd
          (if (functionp cmd-template)
              (funcall cmd-template ivy-text)
            (let* ((command-args
                    (counsel--split-command-args ivy-text))
                   (regex (counsel--grep-regex (cdr command-args)))
                   (extra-switches (counsel--ag-extra-switches regex))
                   (all-args
                    (append
                     (when (car command-args)
                       (split-string (car command-args)))
                     (when extra-switches
                       (split-string extra-switches))
                     (list (counsel--grep-smart-case-flag) regex))))
              (if (stringp cmd-template)
                  (counsel--format
                   cmd-template
                   (mapconcat #'shell-quote-argument all-args " "))
                (cl-mapcan
                 (lambda (x)
                   (if (string= x "%s")
                       (copy-sequence all-args)
                     (list x)))
                 cmd-template)))))
         (cands
          (counsel--split-string
           (if (stringp cmd)
               (shell-command-to-string cmd)
             (custom/async-call cmd)))))))

(defun counsel-codesearch-occur (&optional cands)
  "Generate a custom occur buffer for counsel-codesearch."
  (message "Counsel Codesearch Occur")
  (custom/async-grep-like-occur #'counsel-codesearch-command cands))

(use-package codesearch :ensure t)

;; Custom codesearch intergration with Counsel
(use-package
 counsel-codesearch
 :ensure t
 :requires (counsel codesearch)
 :init
 ;; counsel-codesearch run async process to get results, so ivy--occur-default wouldn't work properly.
 ;; we should provide our own function which will produce occur results
 :config
 (ivy-configure
  'counsel-codesearch
  :occur #'counsel-codesearch-occur
  :exit-codes `(1 "Nada")
  ;; following wouldn't work as it's replaced
  ;; on every call to counsel-codesearch
  ;; :unwind-fn #'counsel-codesearch-unwind 
  )
 ;; (ivy-set-exit-codes '(1 "No codesearch matches found"))
 (bind-keys :map counsel-search-map ("c" . counsel-codesearch))
 ;;Quick shortcut with guessing logic
 :bind (("C-x C-a" . 'counsel-codesearch-or-rg)))
