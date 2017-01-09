(load "XorShift")
(require :XorShifts)

(let (rW r a)
	;�����̐��f�[�^���擾
	(setf rW (make-instance 'XS:XorShift :w (XS:undefaultW)))
	(format t ">> rand 0 to UInt32Max~%")
	(dotimes (i 5)
		(format t "~d~%" (XS:rand rW)))

	;0-100�̗���(100�܂�)�𐮐��Ŏ擾
	(setf r (make-instance 'XS:XorShift))
	(format t ">> randInt 0 to 100~%")
	(dotimes (i 5)
		(format t "~d~%" (XS:randInt r 0 100)))

	;0-1�̗����𕂗V�����_�Ŏ擾
	(format t ">> randFloat 0 to 1~%")
	(dotimes (i 5)
		(format t "~d~%" (XS:randFloat r)))

	;list�̃V���b�t��
	(format t ">> shuffle list~%")
	(setf a (loop for i from 0 below 20 collect i))
	(format t "~A~%" (XS:shuffle r a))
	(format t "~A~%" a)

	;�f�t�H���g�̃V�[�h�l���擾
	(format t ">> defaults~%")
	(format t "~d~%" (XS:defaultX))
	(format t "~d~%" (XS:defaultY))
	(format t "~d~%" (XS:defaultZ))
	(format t "~d~%" (XS:undefaultW))

	;���̗����ɗ^�����V�[�h�l�����l(w�̂�)
	(format t ">> seedW~%")
	(format t "~d~%" (XS:seedW r))

	;���̗������񂵂���
	(format t ">> randCount~%")
	(format t "~d~%" (XS:randCount r))
)