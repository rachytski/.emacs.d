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
  )

(use-package yasnippet
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook
  (((java-mode
     c++-mode
     js-json-mode
     go-mode
     python-mode
     cmake-mode
     ) . lsp-deferred)
   (lsp-mode . lsp-enable-which-key-integration))
  :bind (("C-." . lsp-find-definition)
	 ("C-M-." . lsp-find-definition)
	 ("C-RET" . lsp-execute-code-action))
  :commands
  lsp
  :init 
  (setq gc-cons-threshold 100000000
	read-process-output-max (* 1024 1024)
	lsp-prefer-capf t
	lsp-keymap-prefix "C-x l"
	lsp-highlight-symbol-at-point t
	js-indent-level 2)
  (setq lsp-json-schemas '[(:fileMatch ["CMakePresets.json"] :url "https://cmake.org/cmake/help/latest/_downloads/3e2d73bff478d88a7de0de736ba5e361/schema.json")])
  :custom
  (lsp-auto-execute-action nil)
  (lsp-format-buffer-on-save t)
  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-use-childframe nil))



