;;;(use-package platformio-mode
;;;  :ensure t
;;;  :requires (projectile)
;;;  :hook((c-mode c++-mode) . platformio-conditionally-enable)
;;;  :config
;;;  (setq async-debug nil)
;;;  )

(defun projectile-platformio-project-p (&optional dir)
  "Check if a project contains platformio.ini file.
When DIR is specified it checks DIR's project, otherwise it acts on the current project."
  (projectile-verify-file "platformio.ini" dir))

(projectile-register-project-type 'platformio #'projectile-platformio-project-p
				  :project-file "platformio.ini"
				  :compile "pio run"
				  :run "pio run -t upload"
				  :install "pio run -t upload"
				  :test "pio run -t test")
