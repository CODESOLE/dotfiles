;;; hexl-inspector.el --- ImHex-style Data Inspector for hexl-mode

(require 'cl-lib)
(require 'hexl)

(defvar hexl-inspector-buffer-name "*Hexl Inspector*"
  "Name of the buffer used for the hexl data inspector.")

(defun hexl-inspector--combine-bytes (bytes)
  "Combine list of BYTES (big-endian) into an integer."
  (let ((val 0))
    (dolist (b bytes)
      (setq val (logior (ash val 8) b)))
    val))

(defun hexl-inspector--to-uint (bytes)
  "Convert list of BYTES to an unsigned integer."
  (hexl-inspector--combine-bytes bytes))

(defun hexl-inspector--to-int (bytes bits)
  "Convert list of BYTES to a signed integer of BITS size."
  (let ((val (hexl-inspector--combine-bytes bytes)))
    (if (> (logand val (ash 1 (1- bits))) 0)
        (- val (ash 1 bits))
      val)))

(defun hexl-inspector--decode-ieee754 (bytes mantissa-bits exponent-bits)
  "Decode BYTES into an IEEE 754 floating point number."
  (condition-case nil
      (let* ((bits-total (+ 1 mantissa-bits exponent-bits))
             (val 0)
             (sign 0) (exponent 0) (mantissa 0.0))
        (dolist (b bytes)
          (setq val (logior (ash val 8) b)))
        (setq sign (if (> (logand (ash val (- (1- bits-total))) 1) 0) -1.0 1.0))
        (setq exponent (logand (ash val (- mantissa-bits)) (1- (ash 1 exponent-bits))))
        (let ((m-int (logand val (1- (ash 1 mantissa-bits)))))
          (setq mantissa (/ (float m-int) (float (ash 1 mantissa-bits)))))
        (let ((bias (1- (ash 1 (1- exponent-bits)))))
          (cond
           ((and (= exponent 0) (= mantissa 0.0)) (* sign 0.0))
           ((and (= exponent 0) (> mantissa 0.0))
            (* sign (expt 2.0 (- 1 bias)) mantissa))
           ((and (= exponent (1- (ash 1 exponent-bits))) (= mantissa 0.0))
            (if (< sign 0) -1.0e+INF 1.0e+INF))
           ((and (= exponent (1- (ash 1 exponent-bits))) (> mantissa 0.0))
            0.0e+NaN)
           (t
            (* sign (expt 2.0 (- exponent bias)) (+ 1.0 mantissa))))))
    (error 0.0e+NaN)))

(defun hexl-inspector--format-data (bytes addr)
  "Format the BYTES array into a display string for ADDR."
  (let ((len (length bytes))
        (str (format "Address: 0x%08X\n\n" addr))
        (sep (make-string 55 ?-)))
    (setq str (concat str (format "%-10s | %-20s | %-20s\n" "Type" "Big Endian" "Little Endian")))
    (setq str (concat str sep "\n"))

    ;; 8-bit (Byte)
    (when (>= len 1)
      (let* ((b (cl-subseq bytes 0 1))
             (u8 (hexl-inspector--to-uint b))
             (i8 (hexl-inspector--to-int b 8)))
        (setq str (concat str (format "%-10s | %-20d | %-20d\n" "int8" i8 i8)))
        (setq str (concat str (format "%-10s | %-20d | %-20d\n" "uint8" u8 u8)))
        (setq str (concat str sep "\n"))))

    ;; 16-bit (Short)
    (when (>= len 2)
      (let* ((b (cl-subseq bytes 0 2))
             (br (reverse b))
             (u16-be (hexl-inspector--to-uint b))
             (u16-le (hexl-inspector--to-uint br))
             (i16-be (hexl-inspector--to-int b 16))
             (i16-le (hexl-inspector--to-int br 16)))
        (setq str (concat str (format "%-10s | %-20d | %-20d\n" "int16" i16-be i16-le)))
        (setq str (concat str (format "%-10s | %-20d | %-20d\n" "uint16" u16-be u16-le)))
        (setq str (concat str sep "\n"))))

    ;; 32-bit (Int / Float)
    (when (>= len 4)
      (let* ((b (cl-subseq bytes 0 4))
             (br (reverse b))
             (u32-be (hexl-inspector--to-uint b))
             (u32-le (hexl-inspector--to-uint br))
             (i32-be (hexl-inspector--to-int b 32))
             (i32-le (hexl-inspector--to-int br 32))
             (f32-be (hexl-inspector--decode-ieee754 b 23 8))
             (f32-le (hexl-inspector--decode-ieee754 br 23 8)))
        (setq str (concat str (format "%-10s | %-20d | %-20d\n" "int32" i32-be i32-le)))
        (setq str (concat str (format "%-10s | %-20d | %-20d\n" "uint32" u32-be u32-le)))
        (setq str (concat str (format "%-10s | %-20g | %-20g\n" "float" f32-be f32-le)))
        (setq str (concat str sep "\n"))))

    ;; 64-bit (Long / Double)
    (when (>= len 8)
      (let* ((b (cl-subseq bytes 0 8))
             (br (reverse b))
             (u64-be (hexl-inspector--to-uint b))
             (u64-le (hexl-inspector--to-uint br))
             (i64-be (hexl-inspector--to-int b 64))
             (i64-le (hexl-inspector--to-int br 64))
             (f64-be (hexl-inspector--decode-ieee754 b 52 11))
             (f64-le (hexl-inspector--decode-ieee754 br 52 11)))
        (setq str (concat str (format "%-10s | %-20d | %-20d\n" "int64" i64-be i64-le)))
        (setq str (concat str (format "%-10s | %-20d | %-20d\n" "uint64" u64-be u64-le)))
        (setq str (concat str (format "%-10s | %-20g | %-20g\n" "double" f64-be f64-le)))
        (setq str (concat str sep "\n"))))

    str))

(defun hexl-inspector-update ()
  "Update the inspector buffer with data at the current point."
  (when (and (eq major-mode 'hexl-mode)
             (get-buffer-window hexl-inspector-buffer-name))
    (let ((addr (ignore-errors (hexl-current-address))))
      (when addr
        ;; FIXED: hexl-max-address is a variable, not a function.
        (let* ((max-addr hexl-max-address) 
               (available-bytes (- max-addr addr -1))
               (n (min 8 available-bytes))
               (bytes (list)))
          ;; Read bytes silently without messing up the user's cursor
          (save-excursion
            (dotimes (i n)
              (hexl-goto-address (+ addr i))
              (push (string-to-number (buffer-substring-no-properties (point) (+ (point) 2)) 16) bytes)))
          (setq bytes (nreverse bytes))

          ;; Format and output to the inspector buffer
          (let ((output (hexl-inspector--format-data bytes addr)))
            (with-current-buffer (get-buffer-create hexl-inspector-buffer-name)
              (let ((inhibit-read-only t))
                (erase-buffer)
                (insert output)
                (goto-char (point-min)))
              (unless (eq major-mode 'special-mode)
                (special-mode)))))))))

;;;###autoload
(define-minor-mode hexl-inspector-mode
  "Toggle a live data inspector side-pane for `hexl-mode'."
  :lighter " HexInspect"
  :group 'hexl
  (if hexl-inspector-mode
      (progn
        (add-hook 'post-command-hook #'hexl-inspector-update nil t)
        (display-buffer (get-buffer-create hexl-inspector-buffer-name)
                        '((display-buffer-reuse-window
                           display-buffer-in-side-window)
                          (side . right)
                          (window-width . 60)))
        (hexl-inspector-update))
    (remove-hook 'post-command-hook #'hexl-inspector-update t)
    (let ((win (get-buffer-window hexl-inspector-buffer-name)))
      (when win (delete-window win)))))

(provide 'hexl-inspector)
