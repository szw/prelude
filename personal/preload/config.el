(modify-all-frames-parameters '(
                            (font . "Menlo-12")
                            (vertical-scroll-bars . nil)
                            (horizontal-scroll-bars . nil)
                            (tool-bar-lines 0)
                            (menu-bar-lines 0)
                            ))

;; disable semantic highlighting entirely
;; (setq ensime-sem-high-enabled-p nil)

;; turn off implicits underscoring in default Prelude theme
(setq ensime-sem-high-faces
      '((var . scala-font-lock:var-face)
        (val :inherit font-lock-constant-face :slant italic)
        (varField . scala-font-lock:var-face)
        (valField :inherit font-lock-constant-face :slant italic)
        (functionCall . font-lock-function-name-face)
        (operator . font-lock-keyword-face)
        (param :slant italic)
        (class . font-lock-type-face)
        (trait :inherit font-lock-type-face :slant italic)
        (object . font-lock-constant-face)
        (package . font-lock-preprocessor-face)
        (implicitConversion . nil)
        (implicitParams . nil)
        (deprecated :strike-through "dark gray"))
      )
