from time import time
from copy import copy

class XorShift:
	defaults={
		"x":123456789,
		"y":362436069,
		"z":521288629,
		"w":88675123
	}

	def __init__(self,
		w=int(time()),
		x=None,
		y=None,
		z=None
	):
		if x is None: x=w<<13
		if y is None: y=(w>>9)^(x<<6)
		if z is None: z=y>>7
		self.seeds={"x":x,"y":y,"z":z,"w":w}
		self.randCount=0
		self.__r=self.randGen(w,x,y,z)

	def randGen(self,w,x,y,z):
		while True:
			t=x^(x<<11&0xFFFFFFFF)
			x,y,z=y,z,w
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
		arr=copy(_arr)
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

	def defaultSeed():return type("defaultSeed",(XorShift,),{
		"__init__":lambda self:
			XorShift.__init__(
				self,
				**XorShift.defaults
			)
	})()