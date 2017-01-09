import time
import collections
import copy

class XorShift:
	defaultX=lambda:123456789
	defaultY=lambda:362436069
	defaultZ=lambda:521288629
	undefaultW=lambda:88675123

	def __init__(self,
		w=int(1103515245*time.time()+12345)%0x7FFFFFFF,
		x=None,
		y=None,
		z=None
	):
		if x is None:
			x=XorShift.defaultX()
		if y is None:
			y=XorShift.defaultY()
		if z is None:
			z=XorShift.defaultZ()
		self.seedW=lambda:w
		self.randCount=0
		self.__r=self.randGen(w,x,y,z)

	def randGen(self,w,x,y,z):
		while True:
			t=x^(x<<11&0xFFFFFFFF)
			x=y
			y=z
			z=w
			w=(w^(w>>19))^(t^(t>>8))
			yield w

	def rand(self):
		self.randCount+=1
		return next(self.__r)

	def randInt(self,min=0,max=0x7FFFFFFF):
		return self.rand()%(max+1-min)+min

	def randFloat(self,min=0,max=1):
		return self.rand()%0xFFFF/0xFFFF*(max-min)+min

	def shuffle(self,_arr):
		arr=copy.copy(_arr)
		if isinstance(arr,list):
			isList=True
		elif isinstance(arr,range) or isinstance(arr,tuple):
			isList=True
			arr=list(arr)
		else:
			isList=False
			arr=list(arr)

		for i in range(0,len(arr)-1):
			r=self.randInt(i,len(arr)-1)
			arr[i],arr[r]=arr[r],arr[i]

		if not isList:
			arr=iter(arr)
		return arr

if __name__=="__main__":
	#乱数の生データを取得
	rW=XorShift(XorShift.undefaultW())
	for i in range(5):
		print(rW.randInt())

	#0-100の乱数(100含む)を整数で取得
	r=XorShift()
	for i in range(5):
		print(r.randInt(0,100))

	#0-1の乱数を浮遊小数点で取得
	for i in range(5):
		print(r.randFloat())

	#listのシャッフル
	a=list(range(0,20))
	print(r.shuffle(a))
	print(a)

	#rangeのシャッフル
	b=range(0,20)
	print(r.shuffle(b))
	print(b)

	#tuple(タプル)のシャッフル
	c=tuple(range(0,20))
	print(r.shuffle(c))
	print(c)

	#iter(イテレータ)のシャッフル
	d=iter(range(0,20))
	print([i for i in r.shuffle(d)])
	print([i for i in d])