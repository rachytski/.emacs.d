; Ivy, Counsel and Swiper are parts os the same repo, closely working together
; Ivy is also used as a completion system backend for projectile 
(use-package ivy
  :ensure t
  :bind(:map ivy-minibuffer-map ("C-m" . 'ivy-alt-done)
                                ("C-M-m" . 'ivy-immediate-done)
                                ("TAB" . 'ivy-partial))
  :config
  (ivy-mode 1)
  :custom 
  (ivy-use-virtual-buffers t)
  (ivy-height 10)
  (ivy-count-format "")
  (ivy-initial-inputs-alist nil)
  (ivy-display-style 'fancy)
  (ivy-re-builders-alist '((t . ivy--regex-plus))))

(use-package counsel
  :ensure t
  :config
  (setq gud-key-prefix "\C-]") ; doesn't matter what, just to remove C-x C-a, which is bound to ag
  :bind(("C-x C-a" . 'counsel-rg) ;search in all files from current folder onwards
	("C-x C-b" . 'counsel-projectile-ag) ;search only in project files
	)
  )


(use-package swiper
  :ensure t
  :bind(("C-s" . 'swiper)
        )
  )


