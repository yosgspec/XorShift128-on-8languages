(provide :XorShifts)
(defpackage XorShifts
	(:use common-lisp)
	(:nicknames :XS)
	(:export
		:XorShift
		:defaultX
		:defaultY
		:defaultZ
		:undefaultW
		:seedW
		:randCount
		:rand
		:randInt
		:randFloat
		:shuffle))
(in-package XorShifts)

(defun defaultX() 123456789)
(defun defaultY() 362436069)
(defun defaultZ() 521288629)
(defun undefaultW() 88675123)
(defclass XorShift()(
	(x	:initarg :x
		:initform (defaultX))
	(y	:initarg :y
		:initform (defaultY))
	(z	:initarg :z
		:initform (defaultZ))
	(w)
	(seedW
		:initarg :w
		:reader seedW
		:initform (mod(+(* 1103515245 (get-universal-time)) 12345) #x7FFFFFFF))
	(randCount
		:reader randCount
		:initform 0)))

(defmethod rand((me XorShift))
	(if (= (randCount me) 0) (setf (slot-value me 'w) (slot-value me 'seedW)))
	(incf (slot-value me 'randCount))
	(let (
		(x (slot-value me 'x))
		(y (slot-value me 'y))
		(z (slot-value me 'z))
		(w (slot-value me 'w))
		tt
	)
			(setf tt (logxor x (logand (ash x 11) #xFFFFFFFF)))
			(setf (slot-value me 'x) y)
			(setf (slot-value me 'y) z)
			(setf (slot-value me 'z) w)
			(setf (slot-value me 'w) (logxor (logxor w (ash w -19)) (logxor tt (ash tt -8))))))

(defmethod randInt((me XorShift) &optional (min 0) (max #x7FFFFFFF))
	(+(mod(rand me) (1+(- max min))) min))

(defmethod randFloat((me XorShift) &optional (min 0) (max 1))
	(+(*(float(/(mod(rand me) #xFFFF) #xFFFF)) (- max min)) min))

(defmethod shuffle((me XorShift) _arr)
	(let ((arr (copy-seq _arr)) r tmp)
		(dotimes (i (1- (length arr))) (progn
			(setf r (randInt me i (1- (length arr))))
			(setf tmp (elt arr i))
			(setf (elt arr i) (elt arr r))
			(setf (elt arr r) tmp)))
		arr))