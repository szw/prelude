(tool-bar-mode 0)
(menu-bar-mode 0)

(setq prelude-guru nil)
(setq prelude-use-smooth-scrolling t)
(setq diff-hl-side 'right)
(setq flx-ido-threshold 1000)

(prelude-require-packages '(ido-vertical-mode
                            ido-ubiquitous
                            cql-mode
                            multiple-cursors
                            phi-search
                            ag
                            meghanada
                            golden-ratio
                            sql-indent
                            color-theme-sanityinc-tomorrow))

(setq prelude-whitespace nil)
(setq prelude-auto-save nil)
(setq ido-everywhere t)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(setq ido-default-buffer-method 'selected-window)
(setq ido-default-file-method 'selected-window)
(setq aw-scope 'frame)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'prelude-mode-hook
          (lambda ()
            (define-key prelude-mode-map (kbd "C-c C-p") 'projectile-command-map)
            (define-key prelude-mode-map (kbd "s-p") nil)
            (define-key prelude-mode-map (kbd "s-g") nil)))

(add-hook 'cider-mode-hook
          (lambda ()
            (define-key cider-mode-map (kbd "C-c C-p") nil)))

(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-completion-map (kbd "s-n") 'ido-next-match)
            (define-key ido-completion-map (kbd "s-p") 'ido-prev-match)
            (define-key ido-completion-map (kbd "s-g") 'minibuffer-keyboard-quit)))

(add-hook 'isearch-mode-hook
          (lambda ()
            (define-key isearch-mode-map (kbd "s-g") 'isearch-abort)))

(require 'phi-search)
(require 'phi-replace)

(add-hook 'phi-search-hook
          (lambda ()
            (define-key phi-search-default-map (kbd "s-g") 'phi-search-abort)))

(require 'multiple-cursors)

(add-hook 'multiple-cursors-mode-hook
          (lambda ()
            (define-key mc/keymap (kbd "s-g") 'mc/keyboard-quit)))

(add-hook 'rectangular-region-mode-hook
          (lambda ()
            (define-key rectangular-region-mode-map (kbd "s-g") 'rrm/keyboard-quit)))

(add-hook 'hum/hide-unmatched-lines-mode
          (lambda ()
            (define-key (kbd "s-g") 'hum/keyboard-quit)))

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "M-*") 'mc/mark-all-words-like-this)
(global-set-key (kbd "C-*") 'mc/mark-all-like-this-dwim)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-s->") 'mc/unmark-next-like-this)
(global-set-key (kbd "C-s-<") 'mc/unmark-previous-like-this)
(global-set-key (kbd "C-M->") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-M-<") 'mc/skip-to-previous-like-this)
(global-set-key (kbd "C-s") 'phi-search)
(global-set-key (kbd "C-r") 'phi-search-backward)
(global-set-key (kbd "M-%") 'phi-replace-query)
(global-set-key (kbd "s-§") 'crux-switch-to-previous-buffer)
(global-set-key (kbd "s-b") 'backward-word)
(global-set-key (kbd "s-f") 'forward-word)
(global-set-key (kbd "<C-s-268632066>") 'sp-backward-sexp) ;;C-s-b
(global-set-key (kbd "<C-s-268632070>") 'sp-forward-sexp) ;;C-s-f
(global-set-key (kbd "<C-s-268632085>") 'sp-backward-up-sexp) ;;C-s-u
(global-set-key (kbd "s-a") 'backward-sentence)
(global-set-key (kbd "s-e") 'forward-sentence)
(global-set-key (kbd "s-{") 'backward-paragraph)
(global-set-key (kbd "s-}") 'forward-paragraph)
(global-set-key (kbd "s-<") 'beginning-of-buffer)
(global-set-key (kbd "s->") 'end-of-buffer)
(global-set-key (kbd "s-d") 'kill-word)
(global-set-key (kbd "<s-backspace>") 'backward-kill-word)
(global-set-key (kbd "s-w") 'easy-kill)
(global-set-key (kbd "s-1") 'ace-window)
(global-set-key (kbd "s-x") 'smex)
(global-set-key (kbd "s-_") 'undo-tree-redo)
(global-set-key (kbd "s-z") 'zop-up-to-char)
(global-set-key (kbd "s-q") 'fill-paragraph)
(global-set-key (kbd "s-s") 'sp-splice-sexp)
(global-set-key (kbd "s-n") 'next-line)
(global-set-key (kbd "s-p") 'previous-line)
(global-set-key (kbd "s-g") 'keyboard-quit)
(global-set-key (kbd "C-o") 'crux-smart-open-line)

(define-key key-translation-map (kbd "C-S-s-f") (kbd "C-M-S-f"))
(define-key key-translation-map (kbd "C-S-s-b") (kbd "C-M-S-b"))

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
(add-hook 'text-mode-hook #'toggle-word-wrap)

;; Fix Flyspell language detection (Emacs 25)
(setenv "LANG" "en_US.UTF-8")

;; Workaround OS Sierra / Emacs 25 fullscreen frame closing crash.
;; It looks like an issue with timing related (or similar) to this bug:
;; https://lists.gnu.org/archive/html/bug-gnu-emacs/2016-07/msg00398.html
(defun demaximize-frame (orig-fun &rest args)
  (if (equal (assoc 'fullscreen (frame-parameters))
             (cons 'fullscreen 'fullboth))
      (progn (toggle-frame-fullscreen)
             (sleep-for 2)
             (apply orig-fun args)
             (modify-frame-parameters nil '((fullscreen . fullboth))))
    (apply orig-fun args)))

(advice-add 'delete-frame :around #'demaximize-frame)

(require 'meghanada)
(add-hook 'java-mode-hook (lambda () (meghanada-mode t)))

;; Ensime settings

(require 'ensime)

;; Workaround for https://lists.gnu.org/archive/html/bug-gnu-emacs/2016-09/msg00656.html
(defun set-mouse-tracking ()
  (interactive)
  (set (make-local-variable 'track-mouse) t))

(eval-after-load 'ensime '(define-key ensime-mode-map [mouse-1] 'set-mouse-tracking))

(setq exec-path (append exec-path '("/usr/local/bin")))
(setq ensime-auto-connect 'never) ;; always, ask, never
(setq ensime-startup-snapshot-notification nil)

;; disable semantic highlighting entirely
(setq ensime-sem-high-enabled-p nil)

;; Clojure
;; Disable pair actions on syntax quoting
(sp-local-pair 'clojure-mode "`" nil :actions nil)
(sp-local-pair 'cider-repl-mode "`" nil :actions nil)

;; SQL indentation
(eval-after-load "sql"
  '(load-library "sql-indent"))

(setq sql-indent-offset 1)

(setq sql-indent-first-column-regexp
      (concat "\\(^\\s-*" (regexp-opt '("select" "update" "insert" "delete"
                                        "union" "intersect" "values"
                                        "from" "where" "into" "group" "having" "order"
                                        "set" "on"
                                        "create" "drop" "truncate"
                                        "--" ")") t) "\\(\\b\\|\\s-*\\)\\)\\|\\(^```$\\)"))
