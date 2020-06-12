(use-package avy
  :ensure t
  :bind(("C-;" . 'avy-goto-char)
        ("C-:" . 'avy-goto-char-2)))

(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :bind(:map ivy-mode-map ("C-'" . ivy-avy))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-height 10
        ivy-count-format ""
        ivy-initial-inputs-alist nil
        ivy-display-style 'fancy
        ivy-re-builders-alist '((swiper . ivy--regex-plus)
                                (t . ivy--regex-fuzzy))))

(use-package swiper
  :ensure t
  :bind("C-s" . 'swiper))




