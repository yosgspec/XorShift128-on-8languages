(load "XorShift")
(require :XorShifts)

(let (rW r a)
	;乱数の生データを取得
	(setf rW (make-instance 'XS:XorShift :w (XS:undefaultW)))
	(format t ">> rand 0 to UInt32Max~%")
	(dotimes (i 5)
		(format t "~d~%" (XS:rand rW)))

	;0-100の乱数(100含む)を整数で取得
	(setf r (make-instance 'XS:XorShift))
	(format t ">> randInt 0 to 100~%")
	(dotimes (i 5)
		(format t "~d~%" (XS:randInt r 0 100)))

	;0-1の乱数を浮遊小数点で取得
	(format t ">> randFloat 0 to 1~%")
	(dotimes (i 5)
		(format t "~d~%" (XS:randFloat r)))

	;listのシャッフル
	(format t ">> shuffle list~%")
	(setf a (loop for i from 0 below 20 collect i))
	(format t "~A~%" (XS:shuffle r a))
	(format t "~A~%" a)

	;デフォルトのシード値を取得
	(format t ">> defaults~%")
	(format t "~d~%" (XS:defaultX))
	(format t "~d~%" (XS:defaultY))
	(format t "~d~%" (XS:defaultZ))
	(format t "~d~%" (XS:undefaultW))

	;今の乱数に与えたシード値初期値(wのみ)
	(format t ">> seedW~%")
	(format t "~d~%" (XS:seedW r))

	;今の乱数を回した回数
	(format t ">> randCount~%")
	(format t "~d~%" (XS:randCount r))
)