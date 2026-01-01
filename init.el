(defconst user-init-dir
  (cond
   ((boundp 'user-emacs-directory)
    user-emacs-directory)
   (t
    "~/.emacs.d/")))

(defun user-init-path (subpath)
  (expand-file-name subpath user-init-dir))

(defmacro load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (user-init-path file)))

(defmacro benchmark-load-user-file (file)
  (interactive "f")
  "Benchmark loading a file in current user's configuration directory "
  (require 'benchmark)
  (message "Loading '%s' took %f seconds"
           (user-init-path file)
           (benchmark-elapse (load-file (user-init-path file)))))

(setq custom-file (user-init-path "custom.el"))

(load-user-file "platform.el")
(load-user-file "caches.el")

(load-user-file "packages.el")
(load-user-file "mirror.el")

(load-user-file "benchmarks.el")
(benchmark-load-user-file "emacs.el")
(benchmark-load-user-file "keybindings.el")
(benchmark-load-user-file "eshell.el")
(benchmark-load-user-file "general.el")
(benchmark-load-user-file "layouts.el")

(benchmark-load-user-file "avy.el")
(benchmark-load-user-file "ivy.el")

(benchmark-load-user-file "projectile.el")
(benchmark-load-user-file "codesearch.el")
(benchmark-load-user-file "perspective.el")
(benchmark-load-user-file "treemacs.el")
(benchmark-load-user-file "magit.el")

(benchmark-load-user-file "ai-tools.el")
(benchmark-load-user-file "ai.el")

(benchmark-load-user-file "lsp.el")
(benchmark-load-user-file "company.el")
(benchmark-load-user-file "indentation.el")

(benchmark-load-user-file "react-native.el")
(benchmark-load-user-file "go.el")
(benchmark-load-user-file "python.el")
(benchmark-load-user-file "arduino.el")
(benchmark-load-user-file "platformio.el")
(benchmark-load-user-file "openscad.el")

(benchmark-load-user-file "adb.el")
(benchmark-load-user-file "debugging.el")
(benchmark-load-user-file "origami.el")

(benchmark-load-user-file "colors.el")
(benchmark-load-user-file "custom.el")
