(tool-bar-mode 0)
(menu-bar-mode 0)
(set-scroll-bar-mode nil)

(setq guru-warn-only nil)
(setq prelude-use-smooth-scrolling t)

(prelude-require-packages '(ido-vertical-mode ido-ubiquitous cql-mode iedit))

(setq whitespace-line-column 120)
(setq prelude-auto-save nil)
(setq ido-everywhere t)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(global-set-key (kbd "C-*") 'iedit-mode)

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
