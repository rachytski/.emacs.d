;; Having proper support for Golang developement
;; requires the following:
;; 1. Download and install go, have it on PATH
;; 2. Have proper GOPATH envvar setup - folder for local packages repo
;; 3. Have proper GOROOT envvar setup - folder with Golang installation (root folder, not bin subfolder!)
;; 4. Install gopls following instructions from here:
;; https://github.com/golang/tools/blob/master/gopls/doc/user.md
;; Make sure gopls.exe is also on PATH
(use-package go-mode
  :ensure t
  :hook((go-mode . (lambda () (require 'go-mode) (lsp)))))

  


