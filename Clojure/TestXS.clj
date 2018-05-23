(require 'XorShift)

(let [
	r_def (XorShift/make-XorShift-defaultSeed)
	r_const (XorShift/make-XorShift 100)
	r (XorShift/make-XorShift)
	a (atom nil)
]
	;�f�t�H���g�̃V�[�h�l���擾
	(println ">> defaults")
	(println XorShift/defaults)

	;���̗����ɗ^�����V�[�h�l�����l
	(println ">> seeds in r")
	(println (:seeds r))

	;�����̐��f�[�^���擾
	(println ">> rand 0 to UInt32Max")
	(loop[i 0](when(< i 5)
		(println (XorShift/-rand r_def))
	(recur(inc i))))

	;0-100�̗���(100�܂�)�𐮐��Ŏ擾
	(println ">> randInt 0 to 100")
	(loop[i 0](when(< i 5)
		(println (XorShift/randInt r_const 0 100))
	(recur(inc i))))

	;0-1�̗����𕂗V�����_�Ŏ擾
	(println ">> randFloat 0 to 1")
	(loop[i 0](when(< i 5)
		(println (XorShift/randFloat r))
	(recur(inc i))))

	;list�̃V���b�t��
	;�l�n���ƂȂ�̂Ō��̔z��͔j�󂳂�Ȃ�
	(println ">> shuffle list")
	(reset! a (for[i (range 20)] i))
	(println (XorShift/-shuffle r @a))
	(println @a)

	;���̗������񂵂���
	(println ">> randCount in r")
	(println @(:randCount r))
)