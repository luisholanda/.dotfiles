;;; ~/.dotfiles/doom/layers/+global.el -*- lexical-binding: t; -*-

(def-package! color-identifiers-mode
  :hook (after-init . global-color-identifiers-mode)
  :commands color-identifiers-mode)


(def-package! ace-jump-mode
  :init
  (map! :leader
        :desc "Ace Jump" :n "j" #'ace-jump-word-mode))


(def-package! focus
  :init
  (map! :leader
        :prefix "t" :desc "Focus Mode" :n "f" #'focus-mode))


(def-package! dockerfile-mode
  :mode "Dockerfile"
  :config
  (put 'docker-image-name 'safe-local-variable #'stringp))


(def-package! golden-ratio
  :init
  (golden-ratio-mode 1)
  (map! :leader
        :prefix "t" :desc "Golden Ratio" :n "g" #'golden-ratio-mode))


(run-with-idle-timer 2 t (lambda () (garbage-collect)))

(after! flycheck
  (setq flycheck-check-syntax-automatically '(mode-enabled save)))
(after! which-key
  (setq which-key-idle-delay 0.1))
(after! ivy
  (setq ivy-dynamic-exhibit-delay-ms 200))


(map! :leader :prefix "i"
      :desc "Insert Char" :n "c" #'insert-char)

