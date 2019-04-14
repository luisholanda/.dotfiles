;;; ~/.dotfiles/doom/+core.el -*- lexical-binding: t; -*-

(defun +core--layer-name (layer)
  "Returns the name of the layer given a keyword constant"
  (substring (symbol-name layer) 1))

(defun +core--get-or-else (args key else)
  (or (plist-get args key) (funcall else)))

(defmacro +core--get-layer-arg (args key)
  (let ((key-name (+core--layer-name key)))
    (+core--get-or-else args key (lambda () (+core--missing-function key-name)))))

(defun +core--missing-function (name)
  (error (format "No %s function passed!" name)))

(defmacro load-layer! (layer)
  "Loads layers relative to ./layers directory"
  (let* ((layer-name (+core--layer-name layer))
         (layer-path (concat "layers/+" layer-name)))
    (load! layer-path)))

(provide `+core)
