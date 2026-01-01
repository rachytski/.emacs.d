;; If colors are off, make sure you run your terminal
;; in more than 16-colors palette.
;; On *NIX systems following should help:
;; export TERM=xterm-256color
;; Colors will be quite close, but still not exact.
;; On Windows, when using Terminal application, only
;; 16-colors palette is used, with few presets available in Settings.
;; Closest palette is HalfLight and NOT the Solarized-Light.
(use-package
 solarized-theme
 :ensure t
 :init (load-theme `solarized-light t t)
 ;; https://github.com/belluzj/fantasque-sans
 ;; v1.8.0 is in fonts/ subfolder of this repo
 (set-frame-font "Fantasque Sans Mono-16" nil t)
 ;; Some other options taken from
 ;;http://pragmaticemacs.com/emacs/fun-with-fonts/
 ;;(set-frame-font "DejaVu Sans Mono-14" nil t)
 ;;(set-frame-font "Source Code Pro-14" nil t)
 ;;(set-frame-font "Monaco-14" nil t)
 ;;(set-frame-font "Cousine-14" nil t)
 )

; company's tooltip appearance customization to look better with solarized-light theme
(custom-set-faces
 '(company-tooltip
   ((t (:background "ivory2" :foreground "MistyRose3"))))
 '(company-tooltip-selection
   ((t (:background "LemonChiffon2" :foreground "MistyRose4"))))
 '(company-tooltip-common ((t (:weight bold :foreground "pink1"))))
 '(company-scrollbar-fg ((t (:background "ivory3"))))
 '(company-scrollbar-bg ((t (:background "ivory2"))))
 '(company-tooltip-annotation ((t (:foreground "MistyRose2")))))
