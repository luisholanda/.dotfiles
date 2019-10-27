;;; B
;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-

(load-theme 'doom-tomorrow-night t)

(when window-system
  ;; Maxime window when running Emacs' GUI.
  (add-hook 'window-setup-hook #'toggle-frame-maximized)

  ;; Additional GUI settings for when running on MacOS.
  (when IS-MAC
    ;; Better font aliasing.
    (setq ns-use-thin-smoothing t)

    ;; Use the colorscheme color for the title bar.
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
    (add-to-list 'default-frame-alist '(ns-appearance . dark)))

  ;; Set a nice font.
  (let ((ui-font (font-spec :family "Cascadia Code" :size 12)))
    (setq-default doom-font ui-font
                  doom-unicode-font ui-font)))


;; Change default leader key.
(setq doom-leader-key ";")
(setq-default auto-window-vscroll nil
              user-full-name "Luis Holanda"
              user-mail-address "luiscmholanda@gmail.com"
              doom-gc-cons-threshold (* 2 doom-gc-cons-threshold))

(after! :ui modeline
  (setq +modeline-height 20
        +modeline-buffer-path-function #'+modeline-file-path-from-project))

(set-display-table-slot standard-display-table 'vertical-border ?│)

;; Add mouse scrolling and selection when in terminal
;; For some reason, in alacritty with macOS, xterm-mouse-mode need to be disabled.
(unless window-system
  (require 'mouse)
  (remove-hook 'tty-setup-hook #'xterm-mouse-mode))


;; Add keymap to insert Unicode character by its name
(map! :leader :prefix "i"
      :desc "Insert Char" :n "c" #'insert-char)

;; Run linters only save
(after! flycheck
  (setq flycheck-check-syntax-automatically '(mode-enabled save)))

;; Delay Ivy refreshes
(after! ivy
  (setq ivy-dynamic-exhibit-delay-ms 200))

;; Only show the which-key buffer if we forget some keybinding.
(after! which-key
  (setq which-key-idle-delay 4
        which-key-idle-secondary-delay 0.05))

;;;
;;; GLOBAL PACKAGES
;;;

(use-package! ace-jump-mode
  :init
  (map! :leader :desc "Ace Jump" :n "j" #'ace-jump-word-mode))

(use-package! focus
  :init
  (map! :leader
        :prefix "t" :desc "Focus Mode" :n "f" #'focus-mode))

(use-package! golden-ratio
  :init
  (golden-ratio-mode 1)
  (map! :leader
        :prefix "t" :desc "Golden Ratio" :n "g" #'golden-ratio-mode))

;;; Dockerfile minor mode
(use-package! dockerfile-mode
  :mode "Dockerfile"
  :config
  (put 'docker-image-name 'safe-local-variable  #'stringp))

(use-package! sublimity
  :init
  (sublimity-mode 1))

(when (featurep! :lang web)
  (use-package! emmet-mode
    :hook (sgml-mode css-mode)))

(use-package! highlight-indent-guides
  :config
  (setq highlight-indent-guides-character ?▏))

(use-package! git-gutter
  :config
  ;; Make git-gutter happy with linenum
  (git-gutter:linum-setup)

  ;; Live update the gutter each second.
  (custom-set-variables
   '(git-gutter:update-interval 1))

  ;; Set pretty gutter symbols.
  (custom-set-variables
   '(git-gutter:modified-sign "┃")
   '(git-gutter:added-sign "┃")
   '(git-gutter:deleted-sign "◢")))

;;;
;;; GLOBAL LSP SETTINGS
;;;

(when (featurep! :tools lsp)
  (setq company-lsp-enable-recompletion t)

  (setq lsp-enable-semantic-highlighting t
        lsp-enable-snippet nil)

  (use-package! lsp-ui
    :config
    ;; Initialize doc popup (disabled by default).
    (setq lsp-ui-doc-enable t)

    ;; Fix the horrible popup appearance.
    (custom-set-variables '(frame-background-mode 'dark))
    (set-face-attribute 'lsp-ui-doc-background nil
                        :foreground (doom-color 'fg)
                        :background (doom-lighten (doom-color 'bg) 0.05))

    ;; Rest of setting.
    (setq lsp-ui-doc-include-signature t
          lsp-ui-doc-border (doom-color 'bg)
          lsp-ui-doc-position 'bottom
          lsp-ui-doc-max-height 16
          lsp-ui-doc-max-width 150)))

;;;
;;; COMPLETION AND LINTING SETTINGS
;;;

(when (featurep! :completion company)
  (push 'company-async-files company-backends)
  (setq company-idle-delay 0.05
        company-minimum-prefix-length 2
        company-box-doc-delay 1))


;;;
;;; SYSTEM CLIPBOARD
;;;

;; Make emacs use the system clipboard.
;; TODO: Do we need the system clipboard fix in GUI Emacs?
(when (and IS-MAC (not window-system))
  (defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))

  (defun paste-to-osx (text &optional _)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))

  (setq interprogram-cut-function 'paste-to-osx
        interprogram-paste-function 'copy-from-osx))
