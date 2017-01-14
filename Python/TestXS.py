from XorShift import XorShift

if __name__=="__main__":
	#XorShift乱数ジェネレータの初期化
	# 論文デフォルトシード
	r_def=XorShift.defaultSeed()
	# 固定値シード
	r_const=XorShift(100)
	# 時間シード
	r=XorShift()

	#デフォルトシード値の取得
	print(">> defaults")
	print(XorShift.defaults)

	#適用したシード値の取得
	print(">> seeds in r")
	print(r.seeds)

	#乱数の生データを取得
	print(">> rand 0 to UInt32Max")
	for i in range(5):
		print(r_def.rand())

	#0-100の乱数(100含む)を整数で取得
	print(">> randInt 0 to 100")
	for i in range(5):
		print(r_const.randInt(0,100))

	#0-1の乱数を浮遊小数点で取得
	print(">> randFloat 0 to 1")
	for i in range(5):
		print(r.randFloat())

	#listのシャッフル
	#値渡しとなるので元の配列は破壊されない
	print(">> shuffle list")
	a=list(range(0,20))
	print(r.shuffle(a))
	print(a)

	#rangeのシャッフル
	print(">> shuffle range")
	b=range(0,20)
	print(r.shuffle(b))
	print(b)

	#tuple(タプル)のシャッフル
	print(">> shuffle tuple")
	c=tuple(range(0,20))
	print(r.shuffle(c))
	print(c)

	#iter(イテレータ)のシャッフル
	print(">> shuffle iter")
	d=iter(range(0,20))
	print([i for i in r.shuffle(d)])
	print([i for i in d])

	#今の乱数を回した回数
	print(">> randCount in r")
	print(r.randCount)
