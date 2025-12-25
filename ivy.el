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

;; prioritizing codesearch over rg is .csearchindex is present in some parent directory
(defun counsel-codesearch-or-rg ()
  (interactive)
  (if (codesearch--find-dominant-csearchindex default-directory)
      (counsel-codesearch)
    (counsel-rg))
  )

;; as counsel-codesearch run async process to get results ivy--occur-default wouldn't do.
;; we should provide our own function which will produce occur results
(defun counsel-codesearch-occur (&optional _cands)
  "Generate a custom occur buffer for counsel-codesearch."
  (counsel-grep-like-occur counsel-codesearch-command))

(use-package counsel-codesearch
  :ensure t
  :init
  (ivy-set-occur 'counsel-codesearch 'counsel-codesearch-occur)
)

(use-package counsel
  :ensure t
  :config
  (global-unset-key (kbd "C-x f"))
  (bind-keys* :prefix-map counsel-search-map
	      :prefix "C-x f")
  (bind-keys :map counsel-search-map
	     ("c" . counsel-codesearch)
	     ("r" . counsel-rg)
	     ("a" . counsel-projectile-ag))
  (setq gud-key-prefix "\C-]") ; doesn't matter what, just to remove C-x C-a, which is bound to ag
  :bind(("C-x C-a" . 'counsel-codesearch-or-rg)) ;use codesearch if possible, fallback to rg
  :requires
  (counsel-codesearch)
  )

(use-package swiper
  :ensure t
  :bind(("C-s" . 'swiper)
        )
  )


