(require 'cc-mode)
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/cscope/")

(setq default-directory "~/")

(require 'protobuf-mode)
(require 'go-mode-load)   
(require 'csharp-mode)
(require 'buff-menu+)

(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.proto$" . protobuf-mode) auto-mode-alist))

;;lua mode
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(require 'highlight-symbol)


;; .emacs
;;emacs auto setup
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(c-basic-offset 4)
 '(c-default-style (quote ((other . "linux"))))
 '(case-fold-search t)
 '(column-number-mode t)
 '(ecb-options-version "2.40")
 '(global-font-lock-mode t nil (font-lock))
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(show-paren-mode t nil (paren))
 '(tool-bar-mode nil nil (tool-bar))
 '(transient-mark-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((t (:foreground "cyan"))))
 '(font-lock-comment-face ((t (:foreground "green"))))
 '(font-lock-constant-face ((t (:foreground "red"))))
 '(font-lock-function-name-face ((t (:foreground "cyan" :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "red" :weight bold))))
 '(font-lock-string-face ((t (:foreground "red"))))
 '(font-lock-type-face ((t (:foreground "green" :weight bold))))
 '(font-lock-variable-name-face ((t (:foreground "white"))))
 '(region ((t (:background "yellow" :foreground "black"))))
 '(variable-pitch ((t (:foreground "yellow" :family "helv")))))

(put 'dired-find-alternate-file 'disabled nil)


;;设置编码
(set-language-environment 'UTF-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq-default pathname-coding-system 'utf-8)

;;提示消息
(setq inhibit-startup-message t)
(setq show-paren-style 'parentheses)
(setq kill-ring-max 200)

(c-toggle-auto-hungry-state 1)
(fset 'yes-or-no-p 'y-or-n-p)

;;显示时间
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)


(define-skeleton skeleton-define-head
  "generate preprocess head info automatic" "Define tags:"
  "#ifndef " str
  "\n#define " str
  "\n"
  "\n" _
  "\n"
  "\n#endif//" str
  "\n"
  )
(define-abbrev-table 'c-mode-abbrev-table 
  '(("headx" "" skeleton-define-head 1)))

(define-skeleton skeleton-abbrev-ifor
  "generate for  automatic" nil
  > "for (int i = 0; i < " _ "; i++) {\n" >
  "\n}">  )
(define-abbrev-table 'c-mode-abbrev-table 
  '(("ifor" "" skeleton-abbrev-ifor 1)))

;;设置一些缩写
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(defun my-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
;    (?\" _ "\"")
;    (?\( _ ")")
;    (?\[ _ "]")
    (?{ > \n > _ \n > "}" >)))
  (setq skeleton-pair t)
;  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
;  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
;  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  )
(add-hook 'c-mode-common-hook 'my-auto-pair)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)


;;快捷键
(global-set-key [f1] 'kill-buffer)
(global-set-key [f2] 'highlight-symbol-at-point)
(global-set-key [f3] 'rgrep)
(global-set-key [f4] 'replace-string)
(global-set-key [f5] 'query-replace)
(global-set-key [f9] 'compile)
(global-set-key [f12] 'eshell)

(global-set-key "\M-q" 'dired)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-p" 'ff-find-related-file)
(global-set-key "\M-n" 'find-tag)
(global-set-key "\M-o" 'buffer-menu)


;;编译成功后,子窗口自动隐藏
(setq compilation-finish-functions
      (lambda (buf str)
        (when (and (string= (buffer-name buf) "*compilation*")
                   (not (string-match "exited abnormally" str)))
          (run-at-time 1.1 nil 'delete-windows-on buf)
          )))
