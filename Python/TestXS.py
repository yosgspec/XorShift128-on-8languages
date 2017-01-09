from XorShift import XorShift

if __name__=="__main__":
	#乱数の生データを取得
	rW=XorShift(XorShift.undefaultW())
	print(">> rand 0 to UInt32Max")
	for i in range(5):
		print(rW.rand())

	#0-100の乱数(100含む)を整数で取得
	print(">> randInt 0 to 100")
	r=XorShift()
	for i in range(5):
		print(r.randInt(0,100))

	#0-1の乱数を浮遊小数点で取得
	print(">> randFloat 0 to 1")
	for i in range(5):
		print(r.randFloat())

	#listのシャッフル
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

	#デフォルトのシード値を取得
	print(">> defaults")
	print(XorShift.defaultX())
	print(XorShift.defaultY())
	print(XorShift.defaultZ())
	print(XorShift.undefaultW())

	#今の乱数に与えたシード値初期値(wのみ)
	print(">> seedW")
	print(r.seedW())

	#今の乱数を回した回数
	print(">> randCount")
	print(r.randCount)
