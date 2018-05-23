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
		:shuffle
	)
)
(in-package XorShifts)

(defconstant defaults '(
	(:x . 123456789)
	(:y . 362436069)
	(:z . 521288629)
	(:w . 88675123)
))

(defclass XorShift()(
	(w         :initarg  :w
	           :initform (get-universal-time))
	(x         :initarg  :x
	           :initform nil)
	(y         :initarg  :y
	           :initform nil)
	(z         :initarg  :z
	           :initform nil)
	(seeds     :reader   seeds
	           :initform nil)
	(randCount :reader   randCount
	           :initform 0
	)
))

(defmethod initialize-instance :after ((self XorShift) &key)
	(with-slots (w x y z seeds) self 
		(unless x (setf x (ash w 13)))
		(unless y (setf y (logxor (ash w -9) (ash x 6))))
		(unless z (setf z (ash y -7)))
		(setf seeds `(
			(:x . ,x)
			(:y . ,y)
			(:z . ,z)
			(:w . ,w)
		))
	)
)

(defmethod rand((self XorShift))
	(incf (slot-value self 'randCount))
	(with-slots (w x y z) self
		(let (tt)
			(setf tt (logxor x (logand (ash x 11) #xFFFFFFFF)))
			(setf x y)
			(setf y z)
			(setf z w)
			(setf w (logxor (logxor w (ash w -19)) (logxor tt (ash tt -8))))
		)
	)
)

(defmethod randInt((self XorShift) &optional (min 0) (max #x7FFFFFFF))
	(+(mod(rand self) (1+(- max min))) min)
)

(defmethod randFloat((self XorShift) &optional (min 0) (max 1))
	(+(*(float(/(mod(rand self) #xFFFF) #xFFFF)) (- max min)) min)
)

(defmethod shuffle((self XorShift) _arr)
	(let ((arr (copy-seq _arr)))
		(loop for i from 0 below (1- (length arr)) do
			(let ((r (randInt self i (1- (length arr)))))
				(rotatef (nth i arr) (nth r arr))
			)
		)
		arr
	)
)

(defclass XorShift-defaultSeed(XorShift)(
	(w :initform (rest(assoc :w defaults)))
	(x :initform (rest(assoc :x defaults)))
	(y :initform (rest(assoc :y defaults)))
	(z :initform (rest(assoc :z defaults)))
))
