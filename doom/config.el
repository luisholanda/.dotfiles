;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-
(add-hook 'window-setup-hook #'toggle-frame-maximized)

;(setq scroll-conservatively 101
;      mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil))
;      mouse-wheel-progressive-speed nil)

(setq-default auto-window-vscroll nil
              user-full-name "Luis Holanda"
              user-mail-address "luiscmholanda@gmail.com"

              doom-font (font-spec :family "Iosevka" :size 12)
              doom-unicode-font (font-spec :family "Iosevka" :size 12))

(run-with-idle-timer 2 t (lambda () (garbage-collect)))

(load-theme 'doom-spacegrey t)

(when IS-MAC
  (setq ns-use-thin-smoothing t)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

(when (featurep! :completion company)
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 3
        company-box-doc-delay 0.1))

(when (featurep! :tools lsp)
  (setq +lsp-company-backend 'company-capf))

(when (featurep! :lang rust +lsp)
  (setq rustic-lsp-server 'rust-analyzer))

(after! flycheck
  (setq flycheck-check-syntax-automatically '(mode-enabled save)))
(after! which-key
  (setq which-key-idle-delay 5))
(after! ivy
  (setq ivy-dynamic-exhibit-delay-ms 200))


(after! :ui modeline
  (setq +modeline-height 20
        +modeline-buffer-path-function #'+modeline-file-path-from-project))

(use-package! color-identifiers-mode
  :hook (after-init . global-color-identifiers-mode)
  :commands color-identifiers-mode)

(use-package! ace-jump-mode
  :init
  (map! :leader
        :desc "Ace Jump" :n "j" #'ace-jump-word-mode))

(use-package! focus
  :init
  (map! :leader
        :prefix "t" :desc "Focus Mode" :n "f" #'focus-mode))

(use-package! golden-ratio
  :init
  (golden-ratio-mode 1)
  (map! :leader
        :prefix "t" :desc "Golden Ratio" :n "g" #'golden-ratio-mode))

(map! :leader :prefix "i"
      :desc "Insert Char" :n "c" #'insert-char)

