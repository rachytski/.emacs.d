(use-package
 benchmark-init
 :ensure t
 :init (benchmark-init/activate)
 :hook (after-init . benchmark-init/deactivate))
