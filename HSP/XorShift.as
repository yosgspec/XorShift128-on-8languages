#cmpopt varinit 1

#module XorShift x,y,z,w,_seedW,_randCount
	#uselib "Kernel32"
	#cfunc GetTickCount "GetTickCount"

	#const defaultX 123456789
	#const defaultY 362436069
	#const defaultZ 521288629
	#const undefaultW 88675123
	#modcfunc local seedW
		return _seedW
	#modcfunc local randCount
		return _randCount

	#define new( \
		%1, \
		%2=-1, \
		%3=defaultX@XorShift, \
		%4=defaultY@XorShift, \
		%5=defaultZ@XorShift \
	) dimtype %1,vartype("struct"): newmod %1,XorShift,%2,%3,%4,%5
	#modinit int _w,int _x,int _y,int _z
		if _w!=-1 :w=_w :else :w=(1103515245*GetTickCount()+12345)\0x7FFFFFFF
		_seedW=w
		randCount=0
		x=_x
		y=_y
		z=_z
	return

	#modcfunc xsRand
		_randCount++
		t=x^(x<<11)
		x=y
		y=z
		z=w
		w=(w^(w>>19&0x1FFF))^(t^(t>>8&0xFFFFFF))
	return double(strf("%u",w))

	#define global ctype xsRandInt(%1,%2=0,%3=0x7FFFFFFF) randInt@XorShift(%1,%2,%3)
	#defcfunc local randInt var this,int min,int max
		return int(xsRand(this)\(max+1-min)+min)

	#define global ctype xsRandFloat(%1,%2=0,%3=1) randFloat@XorShift(%1,%2,%3)
	#defcfunc local randFloat var this,double min,double max
		return xsRand(this)\0xFFFF/0xFFFF*(max-min)+min

	#define global xsShuffle(%1,%2,%3) %tshuffle \
		%i=length(%2) :\
		dimtype %3,vartype(%2(0)),%p :\
		foreach %3: %3(cnt)=%2(cnt): loop :\
		shuffle@XorShift %1,%o,%3

	#deffunc local shuffle var this,var arrLength,array arr
		dimtype tmp,vartype(arr(0))
		repeat arrLength-1
			r=xsRandInt(this,cnt,arrLength-1)
			tmp=arr(cnt)
			arr(cnt)=arr(r)
			arr(r)=tmp
		loop
	return
#global
