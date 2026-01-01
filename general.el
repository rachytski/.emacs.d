;; Allows emacs to inherit parent shell environment,
;; instead of using system-wide ones
(use-package exec-path-from-shell :ensure t)

;; Allows mission-control-like switching between emacs buffers
;; Initiate with Ctrl-Tab, continue switching with Tab.
;; Note, that Ctrl-I is the same as Tab, so switching is
;; eeringly similar to Visual Studio tab switching behaviour
;; (which is the goal btw, as its super convenient)
;(use-package buffer-expose
;  :ensure t
;  :bind(("<C-tab>" . buffer-expose-no-stars))
;  )

;; Shows completion for the currently entered partial key
;; https://github.com/justbur/emacs-which-key
(use-package which-key :ensure t :config (which-key-mode))

;; zygospore package is a lifesaver!
(use-package
 zygospore
 :ensure t
 :bind (("C-x 1" . 'zygospore-toggle-delete-other-windows)))
