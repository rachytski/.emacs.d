(require 'cl)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-check-signature nil)
(setq package-user-dir elpa-personal-path)
(package-initialize)
