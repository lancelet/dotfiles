;;; init.el --- GNU Emacs Configuration

;;; Basics inspired from: https://github.com/rememberYou/.emacs.d

;; This program is free software. You can redistribute it and/or modify it under
;; the terms of the Do What The Fuck You Want To Public License, version 2 as
;; published by Sam Hocevar.
;;
;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE.
;;
;; You should have received a copy of the Do What The Fuck You Want To Public
;; License along with this program. If not, see http://www.wtfpl.net/.

;;; Code:

;; Set directories.
(setq user-init-file load-file-name)
(setq user-emacs-directory (file-name-directory user-init-file))

;; Make startup faster by reducing the frequency of garbage
;; collection.
(setq gc-cons-threshold (* 50 1000 1000))

(require 'package)
(package-initialize)

;; Load org mode config
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-begin-commands (quote (self-insert-command)) t)
 '(company-idle-delay 0.1 t)
 '(company-minimum-prefix-length 2 t)
 '(company-show-numbers t t)
 '(company-tooltip-align-annotations t t)
 '(global-company-mode t t)
 '(package-selected-packages
   (quote
    (doom-modeline general evil-leader evil-goggles doom-themes use-package-ensure-system-package evil delight))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
