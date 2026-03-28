;;; init-ia-integration.el --- AI tooling for Emacs
;;; Requires: use-package

;; ------------------------------------------------------------
;; ELLAMA (LLM interface optimized for Ollama)
;; ------------------------------------------------------------

;; (use-package ellama
;;   :ensure t
;;   :defer t
;;   :bind ("C-c e" . ellama)
;;   ;; send last message in chat buffer with C-c C-c
;;   :hook (org-ctrl-c-ctrl-c-hook . ellama-chat-send-last-message)
;;   :init
;;   (setopt ellama-language "English")
;;   :config

;;   ;; backend local ollama
;;   (require 'llm-ollama)

;;   (setopt ellama-provider
;;           (make-llm-ollama
;;            :chat-model "llama3:latest"
;;            :embedding-model "llama3"))

;;   (setopt ellama-coding-provider
;;           (make-llm-ollama
;;            :chat-model "qwen2.5:3b"
;;            :embedding-model "nomic-embed-text"
;;            :default-chat-non-standard-params '(("num_ctx" . 32768))))

;;   (defun ia-ellama-doc-region ()
;;     "Generate documentation for region using ellama."
;;     (interactive)
;;     (if (use-region-p)
;;         (ellama-instant
;;          (format "Write documentation for this code:\n\n%s"
;;                  (buffer-substring-no-properties
;;                   (region-beginning)
;;                   (region-end))))
;;       (message "Select a region first")))

;;   ;; customize display buffer behaviour
;;   ;; see ~(info "(elisp) Buffer Display Action Functions")~
;;   (setopt ellama-chat-display-action-function #'display-buffer-full-frame)
;;   (setopt ellama-instant-display-action-function #'display-buffer-at-bottom)
;;   :config
;;   ;; show ellama context in header line in all buffers
;;   (ellama-context-header-line-global-mode +1)
;;   ;; show ellama session id in header line in all buffers
;;   (ellama-session-header-line-global-mode +1)
;;   ;; handle scrolling events
;;   (advice-add 'pixel-scroll-precision :before #'ellama-disable-scroll)
;;   (advice-add 'end-of-buffer :after #'ellama-enable-scroll))


;; ------------------------------------------------------------
;; GPTEL (Universal LLM interface)
;; ------------------------------------------------------------

;; (use-package gptel
;;   :ensure t
;;   :defer t
;;   :bind ("C-c C-i e" . gptel-menu)
;;   :config
;;   (setq gptel-api-key (getenv "OPENAI_API_KEY"))

;;   ;; (setq gptel-model "llama3:latest"
;;   ;;       gptel-backend
;;   ;;       (gptel-make-ollama "Ollama"
;;   ;;         :host "localhost:11434"
;;   ;;         :stream t
;;   ;;         :models '("llama3:latest" "gemma3:1b")))


;;   ;; (gptel-make-openai "OpenWebUI"
;;   ;;   :host "localhost:3000"
;;   ;;   :protocol "http"
;;   ;;   :key "KEY_FOR_ACCESSING_OPENWEBUI"
;;   ;;   :endpoint "/api/chat/completions"
;;   ;;   :stream t
;;   ;;   :models '("llama3:latest"))


;;   (defun ia-gptel-explain-region ()
;;     "Explain selected code with gptel."
;;     (interactive)
;;     (if (use-region-p)
;;         (gptel-request
;;          (buffer-substring-no-properties (region-beginning) (region-end))
;;          :system "You are a senior developer explaining code.")
;;       (message "Select a region first"))))

;; ------------------------------------------------------------
;; AGENT-SHELL (AI agents via CLI)
;; ------------------------------------------------------------

;; (use-package agent-shell
;;   :ensure t
;;   :defer t
;;   :commands (agent-shell)
;;   :config

;;   ;; ejemplo de agentes
;;   (setq agent-shell-agents
;;         '((aider . "aider")
;;           (claude . "claude")
;;           (codex . "codex")))

;;   (defun ia-agent-run ()
;;     "Run agent-shell."
;;     (interactive)
;;     (call-interactively 'agent-shell)))

;; ------------------------------------------------------------
;; AIDERMACS (AI repo editing / pair programming)
;; ------------------------------------------------------------

;; (use-package aidermacs
;;   :ensure t
;;   :defer t
;;   :commands (aider aider-transient-menu)
;;   :config

;;   ;; opcional: usar modelos externos
;;   ;; (setq aider-args '("--model" "claude-3-sonnet"))

;;   (defun ia-aider-start ()
;;     "Start aider in project root."
;;     (interactive)
;;     (let ((default-directory (or (project-root (project-current)) default-directory)))
;; (call-interactively 'aider))))

;; ------------------------------------------------------------
;; Copilot
;; ------------------------------------------------------------

;; @github/copilot-language-server

(use-package copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion)))

;; ------------------------------------------------------------
;; Unified AI helpers
;; ------------------------------------------------------------

(defun ia-explain-code ()
  "Explain region using preferred AI backend."
  (interactive)
  (cond
   ((featurep 'gptel)
    (call-interactively 'ia-gptel-explain-region))
   ((featurep 'ellama)
    (call-interactively 'ia-ellama-doc-region))
   (t
    (message "No AI backend loaded"))))

(defun ia-refactor-with-aider ()
  "Send refactor request using aider."
  (interactive)
(ia-aider-start))

;; ------------------------------------------------------------
;; Keybindings
;; ------------------------------------------------------------

;; (global-set-key (kbd "C-c i e") 'ia-explain-code)
;; (global-set-key (kbd "C-c i r") 'ia-refactor-with-aider)
;; (global-set-key (kbd "C-c i a") 'ia-agent-run)
;; (global-set-key (kbd "C-c i g") 'gptel)

(provide 'init-ia-integration)

;;; init-ia-integration.el ends here
