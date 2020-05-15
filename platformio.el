(use-package platformio-mode
  :ensure t
  :hook((c-mode c++-mode) . platformio-conditionally-enable))
