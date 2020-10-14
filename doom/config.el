;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-
(add-hook 'window-setup-hook #'toggle-frame-maximized)


(setq-default auto-window-vscroll nil
              user-full-name "Luis Holanda"
              user-mail-address "luiscmholanda@gmail.com"

              doom-font (font-spec :family "SauceCodePro Nerd Font" :size 13)
              doom-unicode-font (font-spec :family "SauceCodePro Nerd Font" :size 13)
              doom-leader-key ";"
              doom-leader-alt-key "C-;"
              doom-localleader-key "; m"
              doom-localleader-alt-key "C-; m")

(run-with-idle-timer 10 t (lambda () (garbage-collect)))

(load-theme 'doom-dark+ t)

(when IS-MAC
  (setq ns-use-thin-smoothing t)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

(setq display-line-numbers-type 'relative)

(when (featurep! :completion company)
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 3
        company-box-doc-delay 0.1))

(when (featurep! :lang rust +lsp)
  (setq rustic-lsp-server 'rust-analyzer))

(after! projectile
  (setq projectile-generic-command "fd . -0 -H -E .git --color=never --type file --type symlink --follow"
        projectile-indexing-method 'alien))

(after! ivy
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (t . ivy--regex-fuzzy))))

(after! evil
  (setq +evil-repeat-keys '(".")))
(after! flycheck
  (setq flycheck-check-syntax-automatically '(mode-enabled save)))
(after! which-key
  (setq which-key-idle-delay 1))
(after! ivy
  (setq ivy-dynamic-exhibit-delay-ms 200))

(after! :tools lsp
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'top
        lsp-ui-doc-max-width 320
        lsp-ui-doc-max-height 32
        lsp-ui-sideline-show-hover t
        lsp-completion-provider 'capf
        read-process-output-max (* 3 1024 1024)))

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

(use-package! tree-sitter
  :init
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package! parinfer-rust-mode
  :hook emacs-lisp-mode
  :init
  (setq parinfer-rust-auto-download t))

(map! :leader :prefix "i"
      :desc "Insert Char" :n "c" #'insert-char)
