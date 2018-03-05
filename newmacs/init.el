;; This loads an Org mode file and builds the configuration code out of it.

;; The path of a directory with operates like .emacs.d
(defconst dotemacs-path (file-name-directory load-file-name)
  "Location of the equivalent of the .emacs.d directory.")
(message "dotemacs-path is `%s'" dotemacs-path)

(let ((gc-cons-threshold most-positive-fixnum))

  ;; Set repositories that we'll pull packages from
  (require 'package)
  (setq-default
   load-prefer-newer t
   package-enable-at-startup nil)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize)

  ;; Install dependencies
  (unless (and (package-installed-p 'delight)
               (package-installed-p 'use-package))
    (package-refresh-contents)
    (package-install 'delight t)
    (package-install 'use-package t))
  (setq-default
   use-package-always-defer t
   use-package-always-ensure t)

  ;; Use an org file for remainder of configuration
  (org-babel-load-file (expand-file-name "dotemacs.org" dotemacs-path))

  (garbage-collect))
