(tool-bar-mode 0)
(menu-bar-mode 0)

(setq guru-warn-only nil)
(setq prelude-use-smooth-scrolling t)
(setq diff-hl-side 'right)

(prelude-require-packages '(ido-vertical-mode
                            ido-ubiquitous
                            cql-mode
                            iedit
                            ag
                            golden-ratio))

(setq whitespace-line-column 120)
(setq prelude-auto-save nil)
(setq ido-everywhere t)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(global-set-key (kbd "C-*") 'iedit-mode)
(global-set-key (kbd "s-b") 'crux-switch-to-previous-buffer)

(add-hook 'golden-ratio-mode-hook
          (lambda ()
            (if golden-ratio-mode
                (golden-ratio)
              (balance-windows))))
(global-set-key (kbd "s-\\") 'golden-ratio-mode)

(defun comment-or-uncomment-lines ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))
(global-set-key (kbd "s-;") 'comment-or-uncomment-lines)

;; various settings
(global-git-commit-mode t)
(setq create-lockfiles nil)
(setq dired-use-ls-dired nil)
(setq ns-pop-up-frames nil)

;; Work around OS X / Emacs 24 fullscreen quit crash.
(defun demaximize-frame (&rest args)
  "Unmaximize the current or passed frame if maximized, otherwise do nothing."
  (if args (select-frame (car args) t))
  (if (equal (assoc 'fullscreen (frame-parameters))
             (cons 'fullscreen 'fullboth))
      (toggle-frame-fullscreen)))
(advice-add 'delete-frame :before #'demaximize-frame)

(require 'ensime)
(setq exec-path (append exec-path '("/usr/local/bin")))
(setq ensime-auto-connect 'always)
(setq ensime-startup-snapshot-notification nil)

;; disable semantic highlighting entirely
(setq ensime-sem-high-enabled-p nil)

;; turn off implicits underscoring in default Prelude theme
;; (setq ensime-sem-high-faces
;;       '((var . scala-font-lock:var-face)
;;         (val :inherit font-lock-constant-face :slant italic)
;;         (varField . scala-font-lock:var-face)
;;         (valField :inherit font-lock-constant-face :slant italic)
;;         (functionCall . font-lock-function-name-face)
;;         (operator . font-lock-keyword-face)
;;         (param :slant italic)
;;         (class . font-lock-type-face)
;;         (trait :inherit font-lock-type-face :slant italic)
;;         (object . font-lock-constant-face)
;;         (package . font-lock-preprocessor-face)
;;         (implicitConversion . nil)
;;         (implicitParams . nil)
;;         (deprecated :strike-through "dark gray"))
;;       )
