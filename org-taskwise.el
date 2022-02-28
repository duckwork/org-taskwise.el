;;; org-taskwise.el --- Be wise about tasks in org-mode -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Case Duckworth

;; Author: Case Duckworth <acdw@acdw.net>
;; Version: 0.1.0
;; Package-Requires: ((emacs "27.2"))
;; URL: https://github.com/duckwork/org-taskwise.el

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

(defun org-taskwise-upto-task ()
  "Go to the heading of the current task."
  (interactive)
  (while (not (org-get-todo-state))
    (org-up-heading-or-point-min)))

(defun org-taskwise-narrow-to-task ()
  "Narrow the buffer to current task."
  (interactive)
  (save-excursion
    (org-taskwise-upto-task)
    (org-narrow-to-subtree)))

(defun org-taskwise-task-clock-in (&optional select start-time)
  "Start the clock on the current task.
SELECT and START-TIME, if provided, are passed on to
`org-clock-in'."
  (interactive)
  (save-excursion
    (org-taskwise-upto-task)
    (call-interactively #'org-clock-in)))

(provide 'org-taskwise)
;;; org-taskwise.el ends here
