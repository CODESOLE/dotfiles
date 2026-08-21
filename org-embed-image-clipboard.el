(defun org-insert-clipboard-image-standalone ()
  "Encodes the clipboard image to base64 and embeds it directly into the org file."
  (interactive)
  (let (b64-string)
    (message "Fetching and encoding image from clipboard...")
    (setq b64-string
          (cond
           ;; macOS
           ((eq system-type 'darwin)
            (shell-command-to-string "pngpaste - | base64"))
           
           ;; Linux
           ((eq system-type 'gnu/linux)
            (if (executable-find "wl-paste")
                ;; Wayland
                (shell-command-to-string "wl-paste -t image/png | base64 -w 0")
              ;; X11
              (shell-command-to-string "xclip -selection clipboard -t image/png -o | base64 -w 0")))
           
           ;; Windows
           ((eq system-type 'windows-nt)
            (shell-command-to-string "powershell -command \"$img = Get-Clipboard -Format Image; if ($img) { $ms = New-Object System.IO.MemoryStream; $img.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png); [Convert]::ToBase64String($ms.ToArray()) }\""))
           
           (t (error "OS not supported for this clipboard script"))))
    
    ;; Strip out any whitespace, newlines, or carriage returns from CLI output
    (setq b64-string (replace-regexp-in-string "[ \t\n\r]+" "" b64-string))
    
    (if (or (string-empty-p b64-string)
            (string-match-p "Error\\|Exception" b64-string))
        (error "Failed to paste image. Is the clipboard empty or are you missing CLI tools?")
      (insert (format "[[data:image/png;base64,%s]]\n" b64-string))
      (message "Image embedded successfully!")
      ;; Display it immediately
      (org-display-inline-images t t))))

;; --- ENABLING INLINE DISPLAY FOR BASE64 LINKS ---

(defun org-display-base64-images (&rest _args)
  "Finds data:image/... links in the buffer and overlays them with the actual image."
  (save-excursion
    (goto-char (point-min))
    ;; Search for our specific base64 link signature
    (while (search-forward "[[data:image/png;base64," nil t)
      (let ((start (match-beginning 0)))
        ;; Ensure we only search up to the end of the current line
        (when (search-forward "]]" (line-end-position) t)
          (let* ((end (point))
                 ;; FIXED: "[[data:image/png;base64," is exactly 24 characters long
                 (raw-data (buffer-substring-no-properties (+ start 24) (- end 2)))
                 ;; Strip accidental whitespaces/newlines just in case the buffer gets formatted
                 (b64-data (replace-regexp-in-string "[ \t\n\r]+" "" raw-data)))
            
            ;; Safely attempt to decode so a bad string doesn't break the whole buffer
            (condition-case err
                (let* ((decoded (base64-decode-string b64-data))
                       (image (create-image decoded 'png t))
                       (ov (make-overlay start end)))
                  (overlay-put ov 'display image)
                  (overlay-put ov 'org-base64-overlay t))
              (error (message "Could not decode base64 image at point %d: %s" start err)))))))))

(defun org-remove-base64-images (&rest _args)
  "Removes base64 image overlays."
  (remove-overlays (point-min) (point-max) 'org-base64-overlay t))

;; Hook our custom display functions into Org's native image toggler
(advice-add 'org-display-inline-images :after #'org-display-base64-images)
(advice-add 'org-remove-inline-images :after #'org-remove-base64-images)

;; Bind it to C-c I (capital i)
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c I") #'org-insert-clipboard-image-standalone))
