(use-package avy
  :ensure t
  :bind(("C-;" . 'avy-goto-char)
        ("C-:" . 'avy-goto-char-2)))

(use-package ivy
  :ensure t
  :bind(:map ivy-minibuffer-map ("C-m" . 'ivy-alt-done)
                                ("C-M-m" . 'ivy-immediate-done))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-height 10
        ivy-count-format ""
        ivy-initial-inputs-alist nil
        ivy-display-style 'fancy
        ivy-re-builders-alist '((t . ivy--regex-plus))))

(use-package swiper
  :ensure t
  :bind("C-s" . 'swiper))




