;; Keeping ADB always alive and in nodaemon mode
;; Any process can kill adb with kill-server and any ports forwarded
;; from such adb will be lost and are required to be re-forwarded again
;; for them to work. That's a problem really, as debugging relies on the
;; jwdp port forwarding before using jdb to connect to debugged application,
;; and anyone (e.g. Android Studio (!!) ) can jump in the middle and break port
;; forwarding. The error message in that case is quite obscure, smth. along
;; "handshake had failed", giving the impression that connection had been
;; actually made but dropped, which is not the case - there was no connection at all.
;; So we need to have our adb always running and be able to restart it immediately
;; when it's killed

(defvar adb-buffer-name "*adb-buffer*")
(defvar adb-process nil)

(defmacro get-adb-buffer ()
  (get-buffer-create adb-buffer-name))

(defun append-adb-buffer (output)
  (with-current-buffer (get-adb-buffer)
    (insert output)))

(defun start-adb-server-nodaemon (sentinel filter)
  (setq adb-process
        (make-process
         :name "adb"
         :buffer (get-adb-buffer)
         :command '("adb" "server" "-a" "nodaemon")
         :sentinel sentinel
         :filter filter
         :noquery t)))

(defun filter-adb-output (process output)
  (append-adb-buffer output))

(defun kill-adb-server ()
  (call-process-shell-command "adb kill-server"))

(defun handle-adb-event (process event)
  (let* ((ev (string-trim-right event)))
    (progn
      (append-adb-buffer
       (format "Process '%s' received '%s' event\n" process ev))
      (cond
       ((equal ev "finished")
        (start-adb-server-nodaemon
         'handle-adb-event 'filter-adb-output))))))

(kill-adb-server)
(start-adb-server-nodaemon 'handle-adb-event 'filter-adb-output)
