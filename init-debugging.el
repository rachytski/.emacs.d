(defun switch-to-debug-on-var-change (&rest _args)
  (debug))

;; (add-variable-watcher 'indent-tabs-mode 'switch-to-debug-on-var-change)

;; remove with:
;; (remove-variable-watcher 'indent-tabs-mode 'switch-to-debug-on-var-change)
