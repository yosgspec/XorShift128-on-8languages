(require 'XorShift)

(let [
	r_def (XorShift/make-XorShift-defaultSeed)
	r_const (XorShift/make-XorShift 100)
	r (XorShift/make-XorShift)
	a (atom nil)
]
	;デフォルトのシード値を取得
	(println ">> defaults")
	(println XorShift/defaults)

	;今の乱数に与えたシード値初期値
	(println ">> seeds in r")
	(println (:seeds r))

	;乱数の生データを取得
	(println ">> rand 0 to UInt32Max")
	(loop[i 0](when(< i 5)
		(println (XorShift/-rand r_def))
	(recur(inc i))))

	;0-100の乱数(100含む)を整数で取得
	(println ">> randInt 0 to 100")
	(loop[i 0](when(< i 5)
		(println (XorShift/randInt r_const 0 100))
	(recur(inc i))))

	;0-1の乱数を浮遊小数点で取得
	(println ">> randFloat 0 to 1")
	(loop[i 0](when(< i 5)
		(println (XorShift/randFloat r))
	(recur(inc i))))

	;listのシャッフル
	;値渡しとなるので元の配列は破壊されない
	(println ">> shuffle list")
	(reset! a (for[i (range 20)] i))
	(println (XorShift/-shuffle r @a))
	(println @a)

	;今の乱数を回した回数
	(println ">> randCount in r")
	(println @(:randCount r))
)