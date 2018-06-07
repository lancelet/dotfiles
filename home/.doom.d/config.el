;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "FuraCode Nerd Font Mono" 
			   :size 14))

(add-hook! haskell-mode
  ;; before expressions in a Haskell layout list
  (setq-default haskell-indentation-layout-offset 4)
  ;; after an opening keyword (eg let)
  (setq-default haskell-indentation-starter-offset 4)
  ;; after an indentation to the left (eg do)
  (setq-default haskell-indentation-left-offset 4)
  ;; before the keyword where
  (setq-default haskell-indentation-where-pre-offset 2)
  ;; after the keyword where
  (setq-default haskell-indentation-where-post-offset 2))
