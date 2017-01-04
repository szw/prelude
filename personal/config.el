(tool-bar-mode 0)
(menu-bar-mode 0)

(setq prelude-guru nil)
(setq prelude-use-smooth-scrolling t)
(setq diff-hl-side 'right)
(setq flx-ido-threshhold 1000)

(prelude-require-packages '(ido-vertical-mode
                            ido-ubiquitous
                            cql-mode
                            iedit
                            ag
                            meghanada
                            golden-ratio))

(setq whitespace-line-column 120)
(setq prelude-auto-save nil)
(setq ido-everywhere t)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(add-hook 'prelude-mode-hook
          (lambda ()
            (define-key prelude-mode-map (kbd "s-p") nil)
            (define-key prelude-mode-map (kbd "s-g") nil)))

(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-completion-map (kbd "s-n") 'ido-next-match)
            (define-key ido-completion-map (kbd "s-p") 'ido-prev-match)))

(require 'meghanada)
(add-hook 'java-mode-hook
          (lambda ()
            (meghanada-mode t)
            (add-hook 'before-save-hook 'delete-trailing-whitespace)))

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
(global-set-key (kbd "s-s") 'sp-splice-sexp)
(global-set-key (kbd "s-n") 'next-line)
(global-set-key (kbd "s-p") 'previous-line)
(global-set-key (kbd "s-g") 'keyboard-escape-quit)
(global-set-key (kbd "C-o") 'crux-smart-open-line)

(add-hook 'golden-ratio-mode-hook
          (lambda ()
            (if golden-ratio-mode
                (golden-ratio)
              (balance-windows))))
(global-set-key (kbd "s-\\") 'golden-ratio-mode)

(defadvice ace-window
    (after golden-ratio-resize-window)
  (golden-ratio) nil)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "s-g") #'company-abort)
  (define-key company-active-map (kbd "s-n") #'company-select-next-or-abort)
  (define-key company-active-map (kbd "s-p") #'company-select-previous-or-abort))

(with-eval-after-load 'popup
  (define-key popup-menu-keymap (kbd "s-g") #'keyboard-quit)
  (define-key popup-menu-keymap (kbd "s-n") #'popup-next)
  (define-key popup-menu-keymap (kbd "s-p") #'popup-previous))

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
