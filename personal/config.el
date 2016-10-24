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
(global-set-key (kbd "s-§") 'crux-switch-to-previous-buffer)
(global-set-key (kbd "s-b") 'backward-word)
(global-set-key (kbd "s-f") 'forward-word)
(global-set-key (kbd "s-a") 'backward-sentence)
(global-set-key (kbd "s-e") 'forward-sentence)
(global-set-key (kbd "s-{") 'backward-paragraph)
(global-set-key (kbd "s-}") 'forward-paragraph)
(global-set-key (kbd "s-<") 'beginning-of-buffer)
(global-set-key (kbd "s->") 'end-of-buffer)
(global-set-key (kbd "s-d") 'sp-kill-word)
(global-set-key (kbd "<s-backspace>") 'sp-backward-kill-word)
(global-set-key (kbd "s-w") 'easy-kill)
(global-set-key (kbd "s-1") 'ace-window)
(global-set-key (kbd "s-x") 'smex)
(global-set-key (kbd "s-_") 'undo-tree-redo)
(global-set-key (kbd "s-z") 'zop-up-to-char)
(global-set-key (kbd "s-q") 'fill-paragraph)

(add-hook 'golden-ratio-mode-hook
          (lambda ()
            (if golden-ratio-mode
                (golden-ratio)
              (balance-windows))))
(global-set-key (kbd "s-\\") 'golden-ratio-mode)

(global-git-commit-mode t)
(setq create-lockfiles nil)
(setq dired-use-ls-dired nil)
(setq ns-pop-up-frames nil)

;; Scratch buffer settings
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message nil)

;; Fix Flyspell language detection (Emacs 25)
(setenv "LANG" "en_US.UTF-8")

;; Workaround OS Sierra / Emacs 25 fullscreen frame closing crash.
;; It looks like an issue with timing related (or similar) to this bug:
;; https://lists.gnu.org/archive/html/bug-gnu-emacs/2016-07/msg00398.html
(defun demaximize-frame (orig-fun &rest args)
  (if (equal (assoc 'fullscreen (frame-parameters))
             (cons 'fullscreen 'fullboth))
      (progn (toggle-frame-fullscreen)
             (sleep-for 1)
             (apply orig-fun args)
             (modify-frame-parameters nil '((fullscreen . fullboth))))
    (apply orig-fun args)))

(advice-add 'delete-frame :around #'demaximize-frame)

;; Ensime settings

(require 'ensime)

;; Workaround for https://lists.gnu.org/archive/html/bug-gnu-emacs/2016-09/msg00656.html
(defun set-mouse-tracking ()
  (interactive)
  (set (make-local-variable 'track-mouse) t))

(eval-after-load 'ensime '(define-key ensime-mode-map [mouse-1] 'set-mouse-tracking))

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
