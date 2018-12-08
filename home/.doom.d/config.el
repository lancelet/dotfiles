;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(add-to-list 'auto-mode-alist '("\\.tbl\\'" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.cmt\\'" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.viw\\'" . sql-mode))

(setq doom-font (font-spec :family "FuraCode Nerd Font"
			   :size 14))

(setq flycheck-python-flake8-executable "flake8")

(load-theme 'doom-nord-light t)

;; (add-hook! haskell-mode
;;   ;; before expressions in a Haskell layout list
;;   (setq-default haskell-indentation-layout-offset 4)
;;   ;; after an opening keyword (eg let)
;;   (setq-default haskell-indentation-starter-offset 4)
;;   ;; after an indentation to the left (eg do)
;;   (setq-default haskell-indentation-left-offset 4)
;;   ;; before the keyword where
;;   (setq-default haskell-indentation-where-pre-offset 2)
;;   ;; after the keyword where
;;   (setq-default haskell-indentation-where-post-offset 2))
