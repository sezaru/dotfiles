;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Set PATH environment variable
;; (let*
;;     ((path-list (list
;;                  "/var/home/sezdocs/.asdf/bin"
;;                  "/var/home/sezdocs/.asdf/shims"
;;                  "/var/home/sezdocs/.local/bin"
;;                  (getenv "PATH")))
;;      (env-path (mapconcat 'identity path-list ":"))
;;      (eshell-path (append exec-path (split-string env-path ":"))))
;;   (setenv "PATH" env-path)
;;   (setq exec-path eshell-path))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-molokai-brighter-modeline t)
;; (setq doom-molokai-brighter-comments t)
(setq doom-theme 'doom-molokai)

;; Use M-x describe-char to find face
(custom-theme-set-faces! 'doom-molokai
  '(default :background "#0e0f0f")
  '(solaire-default-face :background "#141616")
  '(hl-line :background "#141617")
  '(font-lock-comment-face :foreground "#7b858a")
  '(font-lock-doc-face :foreground "#7b858a")
  '(font-lock-function-name-face :foreground "#B6E63E" :weight bold)
  '(font-lock-keyword-face :foreground "#FB2874" :weight bold)
  '(font-lock-type-face :foreground "#34D0C4")
  '(elixir-ts-keyword-key :foreground "#34D0C4")
  '(elixir-ts-comment-doc-identifier :foreground "#7b858a" :weight bold)
  '(org-block :background "#111213"))

(custom-theme-set-faces! 'doom-monokai-pro
  '(default :background "#0e0f0f")
  '(solaire-default-face :background "#141616")
  '(hl-line :background "#141617")
  '(font-lock-comment-face :foreground "#7b858a")
  '(font-lock-doc-face :foreground "#7b858a")
  '(font-lock-variable-name-face :foreground "#FD971F")
  '(font-lock-type-face :foreground "#34D0C4")
  '(elixir-ts-keyword-key :foreground "#34D0C4")
  '(org-block :background "#111213"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

;; Make buffer borders a little bit bigger
(setq window-divider-default-bottom-width 4
      window-divider-default-right-width 4)

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

(map! "C-c g" #'magit-status)

(map! "<f3>" #'eshell)

(setq shell-file-name (executable-find "bash"))

(use-package! vertico
  :bind (:map vertico-map
              ("C-j" . vertico-insert)
              ("C-l" . vertico-directory-up))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(after! projectile
  (add-to-list 'projectile-project-root-files "mix.exs"))

;; (use-package! heex-ts-mode
;;   :defer t
;;   :mode "\\.heex\\'")

;; (setq +tree-sitter-hl-enabled-modes t)

;; (use-package! elixir-ts-mode)



;;  (use-package! elixir-ts-mode
;;   :defer t
;;   :init
;;   ;; Disable default smartparens config. There are too many pairs; we only want
;;   ;; a subset of them (defined below).
;;   (provide 'smartparens-elixir)
;;   :config
;;   (set-ligatures! 'elixir-ts-mode
;;                   ;; Functional
;;                   :def "def"
;;                   :lambda "fn"
;;                   ;; :src_block "do"
;;                   ;; :src_block_end "end"
;;                   ;; Flow
;;                   :not "!"
;;                   :in "in" :not-in "not in"
;;                   :and "and" :or "or"
;;                   :for "for"
;;                   :return "return" :yield "use")

;;   ;; ...and only complete the basics
;;   (sp-with-modes 'elixir-ts-mode
;;     (sp-local-pair "do" "end"
;;                    :when '(("RET" "<evil-ret>"))
;;                    :unless '(sp-in-comment-p sp-in-string-p)
;;                    :post-handlers '("||\n[i]"))
;;     (sp-local-pair "do " " end" :unless '(sp-in-comment-p sp-in-string-p))
;;     (sp-local-pair "fn " " end" :unless '(sp-in-comment-p sp-in-string-p)))

;;   (add-hook 'elixir-ts-mode-local-vars-hook #'lsp! 'append)
;;   (after! lsp-mode
;;     (dolist (match
;;              '("[/\\\\].direnv$"
;;                "[/\\\\]node_modules$"
;;                "[/\\\\]deps"
;;                "[/\\\\]build"
;;                "[/\\\\]_build"))
;;       (add-to-list 'lsp-file-watch-ignored-directories match)))

;;   (after! highlight-numbers
;;     (puthash 'elixir-ts-mode
;;              "\\_<-?[[:digit:]]+\\(?:_[[:digit:]]\\{3\\}\\)*\\_>"
;;              highlight-numbers-modelist)))

;; (use-package! flycheck-credo
;;   :after elixir-ts-mode
;;   :config (flycheck-credo-setup))

;; (use-package! exunit
;;   :hook (elixir-ts-mode . exunit-mode)
;;   :init
;;   (map! :after elixir-ts-mode
;;         :localleader
;;         :map elixir-ts-mode-map
;;         :prefix ("t" . "test")
;;         "a" #'exunit-verify-all
;;         "r" #'exunit-rerun
;;         "v" #'exunit-verify
;;         "T" #'exunit-toggle-file-and-test
;;         "t" #'exunit-toggle-file-and-test-other-window
;;         "s" #'exunit-verify-single))



;; (after! lsp-mode
;;   (setq lsp-lens-enable nil))

;; (use-package! ox-timeline)
