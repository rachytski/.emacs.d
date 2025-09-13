(use-package ivy
  :ensure t
  :bind(:map ivy-minibuffer-map ("C-m" . 'ivy-alt-done)
                                ("C-M-m" . 'ivy-immediate-done)
                                ("TAB" . 'ivy-partial))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-height 10
        ivy-count-format ""
        ivy-initial-inputs-alist nil
        ivy-display-style 'fancy
        ivy-re-builders-alist '((t . ivy--regex-plus))))

(use-package counsel
  :ensure t
  :bind(("C-x C-a" . 'counsel-rg) ;search in all files from current folder onwards
	)
  )

; enhances swiper for C-f command, also used for projectile
(use-package swiper
  :ensure t
  :bind("C-s" . 'swiper))




