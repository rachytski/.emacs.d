;; Language Server Protocol mode for Emacs,
;; uses different servers for different languages,
;; like clangd for C++ and allows for IDE-like functions
;; in Emacs. Specifically, my interest goes with
;; follow-symbol at complete-symbol-at-point functionality
;;
;; https://github.com/emacs-lsp/lsp-mode
;;
;; Language Installation instructions:
;; python: pip install python-lsp-server
;; c++   : will install clangd automatically
;; go    : see go.el

(use-package cmake-mode
  :ensure t
  :mode("CMakeLists\\.txt\\'" "\\.cmake\\'")
  :hook (cmake-mode . lsp-deferred))

(use-package lsp-mode
  :ensure t
  :hook
  (((java-mode
     c++-mode
     go-mode
     python-mode
     cmake-mode
     ) . lsp-deferred)
   (lsp-mode . lsp-enable-which-key-integration))
  :bind (("C-." . lsp-find-definition)
	 ("C-M-." . lsp-find-definition))
  :commands
  lsp
  :init 
  (setq gc-cons-threshold 100000000
	read-process-output-max (* 1024 1024)
	lsp-prefer-capf t
	lsp-keymap-prefix "C-x l"
	lsp-highlight-symbol-at-point t)
  :custom
  (lsp-format-buffer-on-save t)
  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)



