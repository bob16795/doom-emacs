;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "prestosilver"
      user-mail-address "prestosilver.ptp@gmail.com")

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
(setq doom-theme 'doom-mondo)

(setq doom-font (font-spec :family "CascadiaMonoPL Nerd Font Mono" :weight 'semibold :size 16))
(setq doom-themes-treemacs-enable-vriable-pitch nil)
(set-face-attribute 'font-lock-comment-face nil :slant 'italic :weight 'semibold :family "CascadiaMonoPL Nerd Font Mono")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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
(require 'slam-mode)
(require 'bamba-mode)
(require 'zen-mode)
(elcord-mode)
(global-wakatime-mode)

(defun joe-mama ()
  (let* ((banner '("========"
                   "JOE MAMA"
                   "========"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

                                        ; (setq +doom-dashboard-ascii-banner-fn #'joe-mama)

(setq fancy-splash-image "~/.doom.d/EMACS.png")

(setq +doom-dashboard-menu-sections
      '(("Single Player"
         :icon ""
         :action recentf-open-files)
        ("Multi Player"
         :icon ""
         :action projectile-recentf)
        ("Emacs Realms"
         :icon ""
         :action org-agenda)))

(require 'ox-publish)
(setq org-publish-project-alist
      '(
        ("org-notes"
         :base-directory "~/doc/org/"
         :base-extension "org"
         :publishing-directory "~/doc/org_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ("slam-site"
         :base-directory "~/doc/rep/slam/slam/site/"
         :base-extension "org"
         :publishing-directory "~/doc/rep/slam/slam/site_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ("slam-static"
         :base-directory "~/doc/rep/slam/slam/site/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|ico"
         :publishing-directory "~/doc/rep/slam/slam/site_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("slam" :components ("slam-site" "slam-static"))
        ))

(setq frame-title-format
      '(""
        (:eval
         (if (string-match-p (regexp-quote (or (bound-and-true-p org-roam-directory) "\u0000"))
                             (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?\s buffer-file-name))
           "%b"))
        (:eval
         (when-let ((project-name (and (featurep 'projectile) (projectile-project-name))))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))

(setq elcord-use-major-mode-as-main-icon t)
(setq elcord-icon-base "https://raw.githubusercontent.com/bob16795/elcord/master/icons/")
(setq elcord-client-id "779079195929083936")
(setq elcord-mode-icon-alist '((agda-mode . "agda-mode_icon")
                               (assembly-mode . "assembly-mode_icon")
                               (c-mode . "c-mode_icon")
                               (c++-mode . "cpp-mode_icon")
                               (clojure-mode . "clojure-mode_icon")
                               (csharp-mode . "csharp-mode_icon")
                               (comint-mode . "comint-mode_icon")
                               (cperl-mode . "cperl-mode_icon")
                               (elixir-mode . "elixir-mode_icon")
                               (emacs-lisp-mode . (elcord--editor-icon))
                               (enh-ruby-mode . "ruby-mode_icon")
                               (erc-mode . "irc-mode_icon")
                               (erlang-mode . "erlang-mode_icon")
                               (forth-mode . "forth-mode_icon")
                               (fsharp-mode . "fsharp-mode_icon")
                               (gdscript-mode . "gdscript-mode_icon")
                               (haskell-mode . "haskell-mode_icon")
                               (haskell-interactive-mode . "haskell-mode_icon")
                               (hy-mode . "hy-mode_icon")
                               (java-mode . "java-mode_icon")
                               (julia-mode . "julia-mode_icon")
                               (js-mode . "javascript-mode_icon")
                               (kotlin-mode . "kotlin-mode_icon")
                               (go-mode . "go-mode_icon")
                               (latex-mode . "latex-mode_icon")
                               (lisp-mode . "lisp-mode_icon")
                               (magit-mode . "magit-mode_icon")
                               (markdown-mode . "markdown-mode_icon")
                               (meson-mode . "meson-mode_icon")
                               (nim-mode . "nim-mode_icon")
                               (nix-mode . "nix-mode_icon")
                               (ocaml-mode . "ocaml-mode_icon")
                               (org-mode . "org-mode_icon")
                               (pascal-mode . "pascal-mode_icon")
                               (php-mode . "php-mode_icon")
                               (puml-mode . "puml-mode_icon")
                               (puppet-mode . "puppet-mode_icon")
                               (python-mode . "python-mode_icon")
                               (racket-mode . "racket-mode_icon")
                               (ruby-mode . "ruby-mode_icon")
                               (rust-mode . "rust-mode_icon")
                               (rustic-mode . "rust-mode_icon")
                               (solidity-mode . "solidity-mode_icon")
                               (sh-mode . "comint-mode_icon")
                               (terraform-mode . "terraform-mode_icon")
                               (typescript-mode . "typescript-mode_icon")
                               (zig-mode . "zig-mode_icon")
                               (slam-mode . "slam-mode_icon")
                               ("^slime-.*" . "lisp-mode_icon")
                               ("^sly-.*$" . "lisp-mode_icon")))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t))) ; this line activates dot

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook #'+org-pretty-mode)
                                        ;(custom-set-faces!
                                        ;  '(outline-1 :weight extra-bold :height 2.0)
                                        ;  '(outline-2 :weight bold :height 1.5)
                                        ;  '(outline-3 :weight bold :height 1.25)
                                        ;  '(outline-4 :weight semi-bold :height 1.125)
                                        ;  '(outline-5 :weight semi-bold :height 1.0625)
                                        ;  '(outline-6 :weight semi-bold :height 1.03275)
                                        ;  '(outline-8 :weight semi-bold)
                                        ;  '(outline-9 :weight semi-bold))
(custom-set-faces!
  '(org-document-title :height 2.5))
(setq org-agenda-deadline-faces
      '((1.001 . error)
        (1.0 . org-warning)
        (0.5 . org-upcoming-deadline)
        (0.0 . org-upcoming-distant-deadline)))
(defun locally-defer-font-lock ()
  "Set jit-lock defer and stealth, when buffer is over a certain size."
  (when (> (buffer-size) 50000)
    (setq-local jit-lock-defer-time 0.05
                jit-lock-stealth-time 1)))

(add-hook 'org-mode-hook #'locally-defer-font-lock)

(appendq! +ligatures-extra-symbols
          (list :list_property "∷"
                :em_dash       "—"
                :ellipses      "…"
                :arrow_right   "→"
                :arrow_left    "←"
                :arrow_lr      "↔"
                :properties    "⚙"
                :end           "∎"
                :priority_a    #("⚑" 0 1 (face all-the-icons-red))
                :priority_b    #("⬆" 0 1 (face all-the-icons-orange))
                :priority_c    #("■" 0 1 (face all-the-icons-yellow))
                :priority_d    #("⬇" 0 1 (face all-the-icons-green))
                :priority_e    #("❓" 0 1 (face all-the-icons-blue))))

(defadvice! +org-init-appearance-h--no-ligatures-a ()
  :after #'+org-init-appearance-h
  (set-ligatures! 'org-mode nil)
  (set-ligatures! 'org-mode
    :list_property "::"
    :em_dash       "---"
    :ellipsis      "..."
    :arrow_right   "->"
    :arrow_left    "<-"
    :arrow_lr      "<->"
    :properties    ":PROPERTIES:"
    :end           ":END:"
    :priority_a    "[#A]"
    :priority_b    "[#B]"
    :priority_c    "[#C]"
    :priority_d    "[#D]"
    :priority_e    "[#E]"))

(defvar emojify-disabled-emojis
  '(;; Org
    "◼" "☑" "☸" "⚙" "⏩" "⏪" "⬆" "⬇" "❓" "↔"
    ;; Terminal powerline
    "✔"
    ;; Box drawing
    "▶" "◀"
    ;; I just want to see this as text
    "©" "™")
  "Characters that should never be affected by `emojify-mode'.")

;; set transparency
(set-frame-parameter (selected-frame) 'internal-border-width 0)

(setq mode-line-format nil)
(setq-default mode-line-format nil)
(setq lsp-zig-zls-executable "/home/john/.config/Code - Insiders/User/globalStorage/ziglang.vscode-zig/zls_install/zls")

(use-package! zig-mode
  :hook ((zig-mode . lsp-deferred))
  :custom (zig-format-on-save nil)
  :config
  (after! lsp-mode
    (add-to-list 'lsp-language-id-configuration '(zig-mode . "zig"))
    (lsp-register-client
     (make-lsp-client
      :new-connection (lsp-stdio-connection "/home/john/.config/Code - Insiders/User/globalStorage/ziglang.vscode-zig/zls_install/zls")
      :major-modes '(zig-mode)
      :server-id 'zls))))

(after! company
  (setq +lsp-company-backends '(company-tabnine :separate company-capf company-yasnippet))
  (setq company-show-numbers t)
  (setq company-idle-delay 0)
  (setq company-candidates-length 20)
  )
