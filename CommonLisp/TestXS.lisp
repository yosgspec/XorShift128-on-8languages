(load "XorShift")
(require :XorShifts)

(let (
	(r_def (make-instance 'xs:XorShift-defaultSeed))
	(r_const (make-instance 'xs:XorShift :w 100))
	(r (make-instance 'xs:XorShift))
	a
)
	;�f�t�H���g�̃V�[�h�l���擾
	(format t ">> defaults~%")
	(format t "~a~%" xs:defaults)

	;���̗����ɗ^�����V�[�h�l�����l
	(format t ">> seeds in r~%")
	(format t "~a~%" (xs:seeds r))

	;�����̐��f�[�^���擾
	(format t ">> rand 0 to UInt32Max~%")
	(dotimes(i 5)
		(format t "~d~%" (xs:rand r_def))
	)

	;0-100�̗���(100�܂�)�𐮐��Ŏ擾
	(format t ">> randInt 0 to 100~%")
	(dotimes(i 5)
		(format t "~d~%" (xs:randInt r_const 0 100))
	)

	;0-1�̗����𕂗V�����_�Ŏ擾
	(format t ">> randFloat 0 to 1~%")
	(dotimes (i 5)
		(format t "~d~%" (xs:randFloat r))
	)

	;list�̃V���b�t��
	;�l�n���ƂȂ�̂Ō��̔z��͔j�󂳂�Ȃ�
	(format t ">> shuffle list~%")
	(setf a (loop for i from 0 below 20 collect i))
	(format t "~A~%" (xs:shuffle r a))
	(format t "~A~%" a)

	;���̗������񂵂���
	(format t ">> randCount in r~%")
	(format t "~d~%" (xs:randCount r))
)
(quit)
