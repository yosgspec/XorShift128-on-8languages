(provide :XorShifts)
(defpackage XorShifts
	(:use common-lisp)
	(:nicknames :xs)
	(:export
		:XorShift
		:XorShift-defaultSeed
		:defaults
		:seeds
		:randCount
		:rand
		:randInt
		:randFloat
		:shuffle))
(in-package XorShifts)

(defparameter defaults '(
	(:x . 123456789)
	(:y . 362436069)
	(:z . 521288629)
	(:w . 88675123)
))

(defclass XorShift()(
	(w	:initarg :w
		:initform (get-universal-time))
	(x	:initarg :x
		:initform nil)
	(y	:initarg :y
		:initform nil)
	(z	:initarg :z
		:initform nil)
	(seeds
		:initform nil)
	(randCount
		:reader randCount
		:initform 0)))

(defmethod new((me XorShift))
	(unless (slot-value me 'x) (setf (slot-value me 'x) (ash(slot-value me 'w) 13)))
	(unless (slot-value me 'y) (setf (slot-value me 'y) (logxor (ash(slot-value me 'w) -9) (ash(slot-value me 'x) 6))))
	(unless (slot-value me 'z) (setf (slot-value me 'z) (ash(slot-value me 'y) -7)))
	(setf (slot-value me 'seeds) `(
		(:x . ,(slot-value me 'x))
		(:y . ,(slot-value me 'y))
		(:z . ,(slot-value me 'z))
		(:w . ,(slot-value me 'w))
	))
)

(defmethod seeds((me XorShift))
	(if (= (randCount me) 0) (new me))
	(slot-value me 'seeds)
)

(defmethod rand((me XorShift))
	(if (= (randCount me) 0) (new me))
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

(defclass XorShift-defaultSeed(XorShift)(
	(w :initform (rest(assoc :w defaults)))
	(x :initform (rest(assoc :x defaults)))
	(y :initform (rest(assoc :y defaults)))
	(z :initform (rest(assoc :z defaults)))))