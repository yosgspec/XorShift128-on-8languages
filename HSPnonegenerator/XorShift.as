#ifndef XorShift
seedKeys@XorShift="x","y","z","w"
defaults@XorShift=123456789,362436069,521288629,88675123

#module XorShift seeds,randCount,x,y,z,w
	#define global xsSeedKeys seedKeys@XorShift
	#define global ctype xsDefaults(%1) getDictionary@XorShift(%1,defaults@XorShift)
	#modcfunc xsSeeds str key
		return getDictionary(key,seeds)

	#modcfunc xsRandCount
		return randCount

	#defcfunc local getDictionary str key,array dict
		item="undefined"
		foreach seedKeys
			if key=seedKeys(cnt):item=dict(cnt):break
		loop
	return item

	#define new(%1,%2=-1,%3=-1,%4=-1,%5=-1) \
		dimtype %1,5: \
		newmod %1,XorShift,%2,%3,%4,%5
	#modinit int _w,int _x,int _y,int _z
		if _w!=-1 :w=_w :else :w=gettime(7)+1000*(gettime(6)+60*(gettime(5)+60*(gettime(4)+24*gettime(3))))
		if _x!=-1 :x=_x :else :x=w<<13
		if _y!=-1 :y=_y :else :y=(w>>9)^(x<<6)
		if _z!=-1 :z=_z :else :z=y>>7

		seeds=double(strf("%u",x)),double(strf("%u",y)),double(strf("%u",z)),double(strf("%u",w))
		randCount=0
	return

	#modcfunc xsRand
		randCount++
		t=x^(x<<11)
		x=y
		y=z
		z=w
		w=(w^(w>>19&0x1FFF))^(t^(t>>8&0xFFFFFF))
	return double(strf("%u",w))

	#define global ctype xsRandInt(%1,%2=0,%3=0x7FFFFFFF) randInt@XorShift(%1,%2,%3)
	#modcfunc local randInt int min,int max
		return int(xsRand(thismod)\(max+1-min)+min)

	#define global ctype xsRandFloat(%1,%2=0,%3=1) randFloat@XorShift(%1,%2,%3)
	#modcfunc local randFloat double min,double max
		return xsRand(thismod)\0xFFFF/0xFFFF*(max-min)+min

	#define global xsShuffle(%1,%2,%3) %tshuffle \
		%i=length(%2) :\
		dimtype %3,vartype(%2(0)),%p :\
		foreach %3: %3(cnt)=%2(cnt): loop :\
		shuffle@XorShift %1,%o,%3

	#modfunc local shuffle var arrLength,array arr
		dimtype tmp,vartype(arr(0))
		repeat arrLength-1
			r=xsRandInt(thismod,cnt,arrLength-1)
			tmp=arr(cnt)
			arr(cnt)=arr(r)
			arr(r)=tmp
		loop
	return
#global

#module XorShift_defaultSeed seeds,randCount,x,y,z,w
	#define new(%1) \
		dimtype %1,5: \
		newmod %1,XorShift_defaultSeed
	#modinit
		x=xsDefaults("x")
		y=xsDefaults("y")
		z=xsDefaults("z")
		w=xsDefaults("w")
		seeds=x,y,z,w
		randCount=0
	return
#global
#endif