(use-package dap-mode
  :ensure t
  :init
  (dap-mode 1)
  :hook
  (dap-stopped . (lambda (session) (call-interactively #'dap-hydra)))
  (dap-session-created . (lambda (session) (setq lsp-auto-guess-root nil)))
  (dap-terminated . (lambda (session) (setq lsp-auto-guess-root t)))
  :config
  (global-unset-key (kbd "C-x d"))
  (bind-keys* :prefix-map dap-mode-map
	      :prefix "C-x d")
  (bind-keys  :map dap-mode-map
	      ("d" . dap-debug)
	      ("h" . dap-hydra)
	      ("b b" . dap-breakpoint-toggle)
	      ("b c" . dap-breakpoint-condition))
  ;; (print "Configuring DAP-MODE")
  ;; Unlimited number of messages in *Messages* buffer
  ;; (setq message-log-max t)
  ;; Print debugging output to *Messages* buffer, but not to mini-buffer
  ;; (setq dap-print-io t dap-inhibit-io t)
  (setq dap-auto-configure-features '(sessions locals breakpoints controls expressions))
  (setq dap-debug-compilation-keep t)
  (setq dap-auto-show-output t)
  (setq dap-output-buffer-filter '("stdout" "stderr" "console"))
  (setq dap-output-window-min-height 20)
  (setq dap-output-window-max-height 30)
  ;; Configuring lldb
  ;; (print "Configuring CODELLDB")
  (require 'dap-codelldb)
  ;; Don't update version for now, 1.11.5 bundles LLDB20, which is buggy for remote android platform plugin.
  (setq dap-codelldb-extension-version "1.11.4")
  (setq dap-codelldb-download-url
	(format "https://github.com/vadimcn/codelldb/releases/download/v%s/codelldb-linux-x64.vsix" dap-codelldb-extension-version))
  (message "Downloaded %s\n" dap-codelldb-download-url)
  ;; (setq dap-label-output-buffer-category t)
  ;; (print "Configuring DAP-PYTHON")
  (setq dap-python-debugger 'debugpy)
  (require 'dap-python)
  (dap-auto-configure-mode)
  :custom
  (dap-breakpoints-file (user-cache-path ".dap-breakpoints"))
  (dap-ui-repl-histtory-dir `user-cache-dir)
  )



