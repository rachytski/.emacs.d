;; Language Server Protocol mode for Emacs,
;; uses different servers for different languages,
;; like ccls for C++ and allows for IDE-like functions
;; in Emacs. Specifically, my interest goes with
;; follow-symbol at complete-symbol-at-point functionality
;;
;; https://github.com/emacs-lsp/lsp-mode
;;
;; Language Installation instructions:
;; python: install python-language-server and extensions using
;;         pip install python-language-server[all]
;; c++   : see ccls.el
;; go    : see go.el

(use-package lsp-mode
  :ensure t
  :hook((c++-mode . lsp)
        (go-mode . lsp)
        (python-mode . lsp)
        (lsp-mode . lsp-enable-which-key-integration))
  :init(setq gc-cons-threshold 100000000
             read-process-output-max (* 1024 1024)
             lsp-prefer-capf t
             lsp-keymap-prefix "C-c l"
             lsp-highlight-symbol-at-point t)
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company-lsp
  :ensure t
  :commands company-lsp)


