;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(load! "+core")
(load-layer! :global)

(setq scroll-conservatively 101
      mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil))
      mouse-wheel-progressive-speed nil)

(setq-default auto-window-vscroll nil
              user-full-name "Luis Holanda"
              user-mail-address "luiscmholanda@gmail.com"
              gc-cons-threshold (* 2 doom-gc-cons-threshold)

              doom-font (font-spec :family "Iosevka" :size 12)
              doom-unicode-font (font-spec :family "Iosevka" :size 12))

(load-theme 'doom-spacegrey t)

(when IS-MAC
  (setq ns-use-thin-smoothing t)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

(when (featurep! :completion company)
  (load-layer! :company))

(when (featurep! :lang python)
  (load-layer! :python))

(after! :ui modeline
  (setq +modeline-height 20
        +modeline-buffer-path-function #'+modeline-file-path-from-project))


(when (featurep! :lang web)
  (def-package! emmet-mode
    :hook (sgml-mode css-mode)))
