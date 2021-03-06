(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook `irony-mode)
  (add-hook 'c-mode-hook `irony-mode)
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map[remap completion-at-point] `irony-completion-at-point-async)
    (define-key irony-mode-map[remap complete-symbol] `irony-completion-at-point-async))
  (add-hook `irony-mode-hook `my-irony-mode-hook)
  (add-hook `irony-mode-hook `irony-cdb-autosetup-compile-options)
)

(use-package company-irony
  :ensure t
  :config
  (add-to-list 'company-backends 'company-irony))


(require 'irony)
;; irony package settings
;; Windows performance tweaks
;; from https://github.com/Sarcasm/irony-mode
(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))
;; Set the buffer size to 64K on Windows (from the original 4K)
(when (boundp 'w32-pipe-buffer-size)
  (setq irony-server-w32-pipe-buffer-size (* 64 1024)))

(setq irony-server-install-prefix (expand-file-name "builds\\irony" elpa-personal-path))
