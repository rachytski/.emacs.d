(setq-default
 c-default-style "bsd"
 c-basic-offset 2
)
(setq-default tab-width 2)
(setq-default indent-tabs-mode t)
(normal-erase-is-backspace-mode 1)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-?") 'help-command)

(require `package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-check-signature nil)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (scad-preview scad-mode)))
 '(scad-command "c:\\Tools\\OpenSCAD\\openscad.exe")
 '(scad-preview-image-size (quote (1600 . 1800))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
