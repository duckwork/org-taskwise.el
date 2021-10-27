;;; taskwise.el --- easier org task integrations    -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Case Duckworth

;; Author: Case Duckworth <acdw@acdw.ne

;;; License:

;; Everyone is permitted to do whatever with this software, without
;; limitation.  This software comes without any warranty whatsoever,
;; but with two pieces of advice:

;; - Be kind to yourself.

;; - Make good choices.

;;; Commentary:

;; I do a lot of writing at my job.  I organize the different articles and
;; blogs I write by using tasks, but within those tasks I still have
;; headers and such.  So just narrowing to subtree, clocking in, or marking
;; something as done is just ... weird when I'm deep within an article and want
;; to do those things.

;; This package attempts to mitigate some of those issues by adding functions
;; to act on task headings only.  This is like, very alpha.

;;; Code:

(require 'org)

(defun taskwise-narrow-to-task (&optional point)
  "Narrow the buffer to the task POINT is in."
  (interactive "d")
  (when point (goto-char point))
  (if (called-interactively-p 'interactive)
      (save-excursion
        (while (not (or (org-entry-is-done-p)
                        (org-entry-is-todo-p)))
          (acdw/org-previous-heading-widen 1))
        (org-narrow-to-subtree))
    ;; well this is dumb...
    (while (not (or (org-entry-is-done-p)
                    (org-entry-is-todo-p)))
      (acdw/org-previous-heading-widen 1))
    (org-narrow-to-subtree)))

(provide 'taskwise)
;;; taskwise.el ends here
