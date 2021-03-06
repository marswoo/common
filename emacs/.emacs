(add-to-list 'load-path "~/.emacs.d/guorj")
(load "sourcepair.el" 'noerror)
(define-key global-map "\C-ct" 'sourcepair-load)

(load "vespa-style.el")
(load "xcscope.el")


(require 'vespa-style)
(add-hook 'c-mode-common-hook 'vespa-c-mode-hook)
(require 'xcscope)
(define-key global-map [(control f8)]  'cscope-find-this-symbol)
;; move window (Shift + cursor)
(windmove-default-keybindings)
(setq windmove-wrap-around t)
;;;;;;;;

(require 'go-mode-load)
;elated
(add-hook 'c++-mode-hook
      '(lambda ( )
         (c-toggle-hungry-state)))
(add-hook 'c++-mode-hook
      '(lambda ( )
         (flyspell-prog-mode)))

(add-hook 'c++-mode-hook
      '(lambda ( )
         (c-set-style "vespa")))

(setq auto-mode-alist
     (cons '("\\.h\\'" . c++-mode) auto-mode-alist))

(add-to-list 'auto-mode-alist
'("\\..pp\\'" . c++-mode))

(add-to-list 'auto-mode-alist
'("\\.ll\\'" . c++-mode))

(add-to-list 'auto-mode-alist
'("\\.yy\\'" . c++-mode))

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

;;c-mode related
(add-hook 'c-mode-hook
      '(lambda ( )
         (c-toggle-hungry-state)))
(add-hook 'c-mode-hook
      '(lambda ( )
         (flyspell-prog-mode)))

;; locale coding 
(setq locale-coding-system'utf-8) 
(prefer-coding-system'utf-8) 
(set-keyboard-coding-system'utf-8) 
(set-terminal-coding-system'utf-8) 
(set-selection-coding-system'utf-8) 
(set-clipboard-coding-system 'ctext) 
(set-buffer-file-coding-system 'utf-8) 

(global-set-key  (kbd "C-x l") 'windmove-left)
(global-set-key  (kbd "C-x p") 'windmove-up)
(global-set-key  (kbd "C-x d") 'windmove-down)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)


(autoload 'wikipedia-mode "wikipedia-mode.el"
"Major mode for editing documents in Wikipedia markup." t)

(add-to-list 'auto-mode-alist
'("\\.wiki\\'" . wikipedia-mode))

(add-to-list 'auto-mode-alist
'("asc\\.alibaba\\-inc\\.com_index\\.php" . wikipedia-mode))

;;set colors
(set-foreground-color "grey")
(set-background-color "black")
(set-cursor-color "grey")
(set-mouse-color "gold1")

;;(set-scroll-bar-mode nil)

;;set line number
(setq column-number-mode t)
(setq line-number-mode t)

;;parentheses settings
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;transient-mark-mode
(setq transient-mark-mode t);

(setq compile-command "scons -j 6")
(setq compilation-scroll-output t)

;;compilation settings
(defun my-compile()
  "Save buffers and start compile"
  (interactive)
  (save-some-buffers t)
  (switch-to-buffer-other-window "*compilation*")
  (compile compile-command))

(global-set-key [f6] 'my-compile)
(global-set-key [f5] 'compile)

;;eshell settings
(defun open-eshell-other-buffer()
  "Open eshell in other buffer"
  (interactive)
  (split-window-vertically)
  (eshell))
(global-set-key [f8] 'open-eshell-other-buffer)
(global-set-key [f7] 'eshell)

(global-set-key [f11] 'bookmark-set)
(global-set-key [f12] 'list-bookmarks)

;;ido
(require 'ido)
(ido-mode t)

(add-hook 'ido-define-mode-map-hook 'my-ido-keys)
(defun my-ido-keys ()
  "Set up the keymap for `ido'."
  ;; basic config
  (define-key ido-mode-map "C-e" 'ido-edit-input);;ido mode
  ;(define-key ido-mode-map "t" 'ido-complete) ;;complete partial
  (define-key ido-mode-map "C-c" 'ido-complete)
  (define-key ido-mode-map "C-j" 'ido-select-text)
  (define-key ido-mode-map "C-m" 'ido-exit-minibuffer);;exit minibuffer
  (define-key ido-mode-map "?" 'ido-completion-help) ;; list matched
  ;;filter files step by step
  (define-key ido-mode-map [(control ? )] 'ido-restrict-to-matches)
  (define-key ido-mode-map [(control ?@)] 'ido-restrict-to-matches)
  ;; select files
  (define-key ido-mode-map "C-r" 'ido-prev-match)
  (define-key ido-mode-map "C-s" 'ido-next-match)
  (define-key ido-mode-map [right] 'ido-next-match)
  (define-key ido-mode-map [left] 'ido-prev-match)
  ;; switch
  (define-key ido-mode-map "C-t" 'ido-toggle-regexp) ;;reg match
  (define-key ido-mode-map "C-p" 'ido-toggle-prefix) ;;prefix match
  (define-key ido-mode-map "C-c" 'ido-toggle-case)   ;;case match
  (define-key ido-mode-pmap "C-a" 'ido-toggle-ignore) ;;ignore some files
  ;; key define in file/folder mod
  (when (memq ido-cur-item '(file dir))
    (define-key ido-mode-map "C-b" 'ido-enter-switch-buffer);;éæbufferæå
    (define-key ido-mode-map "C-d" 'ido-enter-dired) ;;Diredæå
    (define-key ido-mode-map "C-f" 'ido-fallback-command)
    ;; cycle switch in folder
    ;; use [left] and [right] to match
    (define-key ido-mode-map [down] 'ido-next-match-dir)
    (define-key ido-mode-map [up]   'ido-prev-match-dir)
    ;; backspace define
    (define-key ido-mode-map [backspace] 'ido-delete-backward-updir)
    ;(define-key ido-mode-map "d"        'ido-delete-backward-updir)
    (define-key ido-mode-map [(meta backspace)] 'ido-delete-backward-word-updir)
    (define-key ido-mode-map [(control backspace)] 'ido-up-directory)
    ;; 
    (define-key ido-mode-map [(meta ?d)] 'ido-wide-find-dir)
    (define-key ido-mode-map [(meta ?f)] 'ido-wide-find-file)
    (define-key ido-mode-map [(meta ?k)] 'ido-forget-work-directory)
    (define-key ido-mode-map [(meta ?m)] 'ido-make-directory)
    (define-key ido-mode-map [(meta down)] 'ido-next-work-directory)
    (define-key ido-mode-map [(meta up)] 'ido-prev-work-directory)
    (define-key ido-mode-map [(meta left)] 'ido-prev-work-file)
    (define-key ido-mode-map [(meta right)] 'ido-next-work-file)
    ;; search in directories
    ;; C-_ to undo
    (define-key ido-mode-map [(meta ?s)] 'ido-merge-work-directories)
    (define-key ido-mode-map [(control ?\_)] 'ido-undo-merge-work-directory)
    )
  (when (eq ido-cur-item 'file)
    (define-key ido-mode-map "C-k" 'ido-delete-file-at-head)
    (define-key ido-mode-map "C-l" 'ido-toggle-literal)
    (define-key ido-mode-map "C-o" 'ido-copy-current-word)
    (define-key ido-mode-map "C-v" 'ido-toggle-vc)
    (define-key ido-mode-map "C-w" 'ido-copy-current-file-name)
    )

  (when (eq ido-cur-item 'buffer)
    (define-key ido-mode-map "C-b" 'ido-fallback-command)
    (define-key ido-mode-map "C-f" 'ido-enter-find-file)
    (define-key ido-mode-map "C-k" 'ido-kill-buffer-at-head)
    ))


(custom-set-variables
 '(semantic-default-submodes (quote (global-semantic-decoration-mode global-semantic-idle-completions-mode
                                     global-semantic-idle-scheduler-mode global-semanticdb-minor-mode
                                     global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode)))
 '(semantic-idle-scheduler-idle-time 3))

(semantic-mode)

;; smart complitions
(require 'semantic/ia)
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))

;;cache path for semanticdb
(setq semanticdb-default-save-directory
      (expand-file-name "~/.emacs.d/semantic.cache/semanticdb"))

;; customisation of modes
(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
;;  (local-set-key "\M-/" 'semantic-ia-complete-symbol)
  ;;
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  )

;;(add-hook 'semantic-init-hooks 'my-cedet-hook)
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'lisp-mode-hook 'my-cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'my-cedet-hook)
;; (add-hook 'erlang-mode-hook 'my-cedet-hook)

(menu-bar-mode)
(setq backup-by-copying-when-linked t)
(load "python") ;; fix python-mode problems

(require 'ansi-color)
(add-hook 'compilation-filter-hook
          '(lambda ()
             (let ((min (point-min-marker))
                   (max (point-max-marker)))
               (ansi-color-apply-on-region min max))))

;; highlight space characters at tail
;; set colors
(custom-set-faces
 '(my-tab-face            ((((class color)) (:background "grey10"))) t)
 '(my-trailing-space-face ((((class color)) (:background "gray10"))) t)
 '(my-long-line-face ((((class color)) (:background "gray50"))) t))

;; define assist function
(defun cc-mode-add-keywords (mode)
  (font-lock-add-keywords
   mode
   '(("\t+" (0 'my-tab-face append))
     ("^.\\{81\\}\\(.+\\)$" (1 'my-long-line-face append)))))

;; Only valid in specified mode
(cc-mode-add-keywords 'c-mode)
(cc-mode-add-keywords 'cc-mode)
(cc-mode-add-keywords 'c++-mode)
(cc-mode-add-keywords 'perl-mode)
(cc-mode-add-keywords 'python-mode)

;; look up dictionary by curl
(defun curl-dict-cn ()
  (interactive)
  (message
   (replace-regexp-in-string
    "<[^>]+>" " "
    (reduce 'concat
            (remove-if-not (lambda(s) (numberp (string-match "<key\\|<def" s)))
                           (split-string
                            (shell-command-to-string
                             (concat "curl -s 'http://api.dict.cn/ws.php?utf8=true&q=" (current-word) "'")) "\n"  t)
                           )))))
(global-set-key  (kbd "C-c l") 'curl-dict-cn)

;;Docbook
(load "docbook-xml-mode.el" 'noerror)
(require 'docbook-xml-mode)
(add-hook 'docbook-xml-mode-hook
          (function (lambda ()
                      (setq outline-regexp "<!\\-\\-\\*+")
                      (outline-minor-mode)
                      (hide-body))))

;; Include settings
(require 'semantic/bovine/gcc)
(require 'semantic/bovine/c)

(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public" "."
        "../.." "../../include" "../../inc" "../../common" "../../public"))

(setq cedet-sys-include-dirs (list
                              "/usr/include"
                              "/usr/include/bits"
                              "/usr/include/glib-2.0"
                              "/usr/include/gnu"
                              "/usr/local/include"))

(let ((include-dirs cedet-user-include-dirs))
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

(setq semantic-c-dependency-system-include-path "/usr/include/")
(put 'upcase-region 'disabled nil)


(when (load "flymake" t)
(
    defun flymake-pycheckers-init ()
    (
        let*
        (
            (

                temp-file

                (

                    flymake-init-create-temp-buffer-copy

                    'flymake-create-temp-inplace

                )

            )

            (

                local-file

                (

                    file-relative-name

                    temp-file

                    (

                        file-name-directory buffer-file-name

                    )

                 )

            )

        )

        (

            list "pyflakes"  (list local-file)

        )

    )

 

    (add-to-list 'flymake-allowed-file-name-masks

                  '("\\.py\\'" flymake-pycheckers-init))

    )

)
