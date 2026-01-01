;(use-package golden-ratio
;  :ensure t
;  :init
;  (golden-ratio-mode 1)
;  :config
;  (setq golden-ratio-auto-scale 1))

;; Windmove binding for quick windows navigation
;; (WASD-style but with IJKL)

(global-set-key (kbd "C-M-j") 'windmove-left)
(global-set-key (kbd "C-M-l") 'windmove-right)
(global-set-key (kbd "C-M-i") 'windmove-up)
(global-set-key (kbd "C-M-k") 'windmove-down)

;; Window size management

(global-set-key (kbd "C-M-S-j") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-S-l") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-S-i") 'shrink-window)
(global-set-key (kbd "C-M-S-k") 'enlarge-window)

;;(defun custom/compilation-layout-hook ()
;;  (when (not (get-buffer-window "*compilation*"))
;;    (save-selected-window
;;      (save-excursion
;;        (let* ((wnd (split-window-vertically))
;;               (h (window-height wnd)))
;;          (select-window wnd)
;;          (switch-to-buffer "*compilation*")
;;          (shrink-window (- h compilation-window-height)))))))
;;(add-hook 'compilation-mode-hook 'custom/compilation-layout-hook)

(setq eshell-window-height 20)

(defun custom/eshell-layout-hook ()
  (when (not (get-buffer-window "*eshell*"))
    (save-selected-window
      (save-excursion
        (let* ((wnd (split-window-vertically))
               (h (window-height wnd)))
          (select-window wnd)
          (switch-to-buffer "*eshell*")
          (shrink-window (- h eshell-window-height)))))))
(add-hook 'eshell-mode-hook 'custom/eshell-layout-hook)

(use-package
 window-purpose
 :ensure t
 :init
 (purpose-mode t)
 (add-to-list 'purpose-user-mode-purposes `(c-mode . edit))
 (add-to-list 'purpose-user-mode-purposes `(asm-mode . edit))
 (add-to-list 'purpose-user-mode-purposes `(c++-mode . edit))
 (add-to-list
  'purpose-user-mode-purposes
  `((compilation-mode
     ag-mode
     ripgrep-search-mode
     dap-server-log-mode
     platformio-compilation-mode)
    . compilation))
 (add-to-list 'purpose-user-name-purposes `("*CMake Help*" . help))
 (add-to-list 'purpose-user-mode-purposes `(eshell-mode shell))
 (purpose-compile-user-configuration))
