;;; wh-browse.el --- -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(defgroup browse-streams nil
  "Browse videos and things."
  :group 'emacs)

(defconst browse-streams-player (if (eq system-type 'darwin) "iina" "mpv"))

(defcustom browse-streams-streams nil
  "Favorite streams."
  :group 'browse-streams
  :type '(repeat string))

(defun browse-url-video-player (url &optional timecode)
  "Browse URL in appropriate video player at the given TIMECODE."
  (if timecode
      (start-process browse-streams-player nil browse-streams-player "--start" timecode (shell-quote-wildcard-pattern url))
    (start-process browse-streams-player nil browse-streams-player (shell-quote-wildcard-pattern url))))

;;;###autoload
(defun browse-stream (stream)
  "Open STREAM in external player."
  (interactive "sChannel: ")
  (browse-url-video-player (format "https://twitch.tv/%s" stream)))

;;;###autoload
(defun browse-video (video)
  "Open VIDEO in external player."
  (interactive "sURL: ")
  (browse-url-video-player video))

;;;###autoload
(defun browse-video-at (video timecode)
  "Open VIDEO in external player at TIMECODE."
  (interactive "sURL: \nsTimecode: ")
  (browse-url-video-player video timecode))

(provide 'wh-browse)

;;; wh-browse.el ends here
