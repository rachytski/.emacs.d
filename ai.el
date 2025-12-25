(use-package gptel
  :ensure t
  :requires treemacs
  :bind (("C-x / /" . gptel)
	 ("C-x / m" . gptel-menu)
	 ("C-x RET" . gptel-send)) ; make it hydra
  :config
  (message "Configuing GPTEL")
  (require 'gptel-ollama)
  (require 'gptel-gemini)
  (require 'gptel-anthropic)
  (defvar gptel--my-gemini
    (gptel-make-gemini
       "My Gemini"
       :key 'gptel-gemini-api-key
       :stream t))
  (defvar gptel--my-ollama
    (gptel-make-ollama
	"My Ollama"
        :key 'gptel-ollama-api-key
	:models '(deepseek-r1:1.5b deepseek-r1:8b)
	:stream t))
  (setq gptel-use-tools 'force)
  (setq gptel-backend gptel--my-gemini)
  (setf (alist-get 'default gptel-directives) #'default-system-directive-fn)
  (setq gptel--system-message 'default-system-directive-fn)
  (setq gptel-gh-github-token-file (user-cache-path "copilot-chat/github-token"))
  (setq gptel-gh-token-file (user-cache-path "copilot-chat/token"))
  (cline-setup-tools)
  :custom
  (gptel-log-level 'debug)
  )

