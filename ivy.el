;; Ivy, Counsel and Swiper are parts os the same repo, closely working together
;; Ivy is also used as a completion system backend for projectile

(use-package
 ivy
 :ensure t
 :bind
 (:map
  ivy-minibuffer-map
  ("C-m" . 'ivy-alt-done)
  ("C-M-m" . 'ivy-immediate-done)
  ("TAB" . 'ivy-partial))
 :config
 (message "Configuring IVY")
 (ivy-mode 1)
 :custom
 (ivy-use-virtual-buffers t)
 (ivy-height 10)
 (ivy-count-format "")
 (ivy-initial-inputs-alist nil)
 (ivy-display-style 'fancy)
 (ivy-re-builders-alist '((t . ivy--regex-plus))))

(use-package swiper :ensure t :bind (("C-s" . 'swiper)) :requires ivy)

(use-package
 counsel
 :ensure t
 :requires (ivy swiper)
 :config
 (global-unset-key (kbd "C-x f"))
 (bind-keys* :prefix-map counsel-search-map :prefix "C-x f")
 (bind-keys
 :map
  counsel-search-map
  ("r" . counsel-rg)) ;; map will be extended by respective extension packages
 (setq gud-key-prefix "\C-]") ; doesn't matter what, just to remove C-x C-a, which is bound to ag
 )
