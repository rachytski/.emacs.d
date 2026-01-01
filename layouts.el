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
