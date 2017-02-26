(modify-all-frames-parameters '((font . "SF Mono-12")
                                (vertical-scroll-bars . nil)
                                (horizontal-scroll-bars . nil)
                                (tool-bar-lines 0)
                                (menu-bar-lines 0)
                                (width . 160)
                                (height . 50)))

(setq ad-redefinition-action 'accept)
(setq exec-path-from-shell-check-startup-files nil)

(set-frame-position (selected-frame)
                    (/ (- (x-display-pixel-width) (frame-pixel-width)) 2)
                    (/ (- (x-display-pixel-height) (frame-pixel-height)) 2))
