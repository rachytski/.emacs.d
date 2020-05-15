;; arduino-mode provides very basic c-mode derived
;; syntax highlighting and few usefull functions to
;; compile, verify and upload sketches.
;; NB: no sophisticated lsp-mode code completion yet.
;; NB2: It's actually better to rename *.ino files to *.cpp,
;; insert "#include <Arduino.h>" at the top of the file
;; and use platformio to generate compile database, so that
;; you'll get the full lsp goodness on your project.
;; Supporting *.ino files in ccls and lsp requires adding
;; new language-id on lsp side and hacking ccls codebase,
;; which is reliant on clang code to identify languages from extension.
;; And here lies the problem - *.ino file doesn't represent anything
;; new, all keywords are perfectly valid
;; C++ constructs once you include Arduino.h file from the
;; corresponding toolchain. So there're very few reasons to treat
;; *.ino files as a separate language. That said it's better not to use
;; arduino-mode at all
;(use-package arduino-mode
;  :ensure t)



