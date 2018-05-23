(load "XorShift")
(require :XorShifts)

(let (
	(r_def (make-instance 'xs:XorShift-defaultSeed))
	(r_const (make-instance 'xs:XorShift :w 100))
	(r (make-instance 'xs:XorShift))
	a
)
	;デフォルトのシード値を取得
	(format t ">> defaults~%")
	(format t "~a~%" xs:defaults)

	;今の乱数に与えたシード値初期値
	(format t ">> seeds in r~%")
	(format t "~a~%" (xs:seeds r))

	;乱数の生データを取得
	(format t ">> rand 0 to UInt32Max~%")
	(dotimes(i 5)
		(format t "~d~%" (xs:rand r_def))
	)

	;0-100の乱数(100含む)を整数で取得
	(format t ">> randInt 0 to 100~%")
	(dotimes(i 5)
		(format t "~d~%" (xs:randInt r_const 0 100))
	)

	;0-1の乱数を浮遊小数点で取得
	(format t ">> randFloat 0 to 1~%")
	(dotimes (i 5)
		(format t "~d~%" (xs:randFloat r))
	)

	;listのシャッフル
	;値渡しとなるので元の配列は破壊されない
	(format t ">> shuffle list~%")
	(setf a (loop for i from 0 below 20 collect i))
	(format t "~A~%" (xs:shuffle r a))
	(format t "~A~%" a)

	;今の乱数を回した回数
	(format t ">> randCount in r~%")
	(format t "~d~%" (xs:randCount r))
)
(quit)
