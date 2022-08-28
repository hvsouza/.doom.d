;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(add-to-list 'bdf-directory-list "/usr/share/emacs/fonts/bdf")
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
;; best thing in emacs..
(use-package! nyan-mode
  :ensure t
  :init
  (setq nyan-animate-nyancat t)
  :config
  (nyan-mode)
  (nyan-toggle-wavy-trail)
  )


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Henrique Souza"
      user-mail-address "henriquevieira.souza@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 17)
;;     doom-variable-pitch-font (font-spec :family "Ubuntu" :size 17))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  )
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-hide-emphasis-markers t)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(setq evil-normal-state-cursor '(bar "yellow"))
(setq-default tab-width 2)
;; (setq indent-line-function 'insert-tab)

(load "server")
(unless (server-running-p) (server-start))

;; to remove tabs and replace by space
(setq-default indent-tabs-mode nil)

;; ;; use-package which-key
;;   :ensure t
;;   :config (which-key-mode))

;; To fix undo tree from showing on the left..
(defadvice! +popup--use-popup-window-for-undo-tree-visualizer-a (fn &rest args)
  :around #'undo-tree-visualize
  (if undo-tree-visualizer-diff
      (apply fn args)
    (letf! ((#'switch-to-buffer-other-window #'pop-to-buffer))
      (apply fn args))))

; show parentheses stuff
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq blink-matching-paren 'show)
;;(setq blink-matching-paren-distance nil)

(use-package! smartparens
:ensure t
  :hook (prog-mode . smartparens-mode)
  :custom
  (sp-escape-quotes-after-insert nil)
  :config
  (require 'smartparens-config)
  ;; :bind
  ;; ;; set as C-M-f or b
  ;; ("C-M-b" . sp-backward-sexp)
  ;; ("C-M-f" . sp-forward-sexp)
  ;; ("C-M-(" . sp-rewrap-sexp)
  ;; ("C-M-)" . sp-splice-sexp)
  )
(show-paren-mode t)

;; setting swiper in case necessary
(use-package! swiper
  :ensure t
  :bind
  (("C-s" . swiper-isearch))
  (("C-r" . swiper-isearch-backward))
  )

;; setting custom key binding
(map! "C-M-y" 'counsel-yank-pop)

;; to flash cursor
(use-package! beacon)
(beacon-mode 1)

;; Org mode table of content
(use-package! org-make-toc
  :ensure t)

;; Org-mode stuff
(use-package! org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Org-mode export issue
(setq org-export-with-broken-links 'mark)

(add-hook 'org-mode-hook 'visual-line-mode)

;; setq highlight-indentation-overlay-string "|")
;; (highlight-indentation-mode t)
;; (add-hook 'org-mode-hook 'highlight-indentation-mode)
;; (add-hook 'emacs-lisp-mode-hook 'highlight-indentation-mode)
;; (add-hook 'c++-mode-hook 'highlight-indentation-mode)
;; (add-hook 'sh-mode-hook 'highlight-indentation-mode)


;; ;; use emacs bindings in insert-mode
;; (setq evil-disable-insert-state-bindings t)
;; (setq evil-want-keybinding nil)

(setq fancy-splash-image "~/.doom.d/doom-emacs-black-hole.png")
;; (setq fancy-splash-image "~/.doom.d/doom-emacs-color2.png")

;; (after! centaur-tabs (centaur-tabs-group-by-projectile-project))
(after! centaur-tabs
  (setq centaur-tabs-set-bar 'right))

;; Dired, use ^ or - to go back without creating a new buffer
;; obs: use a to go foward without creating a new buffer
(remove-hook! 'dired-mode-hook 'dired-omit-mode)
(map! :after dired
      :map dired-mode-map
      :gn "RET" 'dired-find-alternate-file
      :gnv "-" (lambda () (interactive) (find-alternate-file "..")))
