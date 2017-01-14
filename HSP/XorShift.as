#cmpopt varinit 1

#module XorShift x,y,z,w,seeds,randCount
	#deffunc local staticNew
		seedKeys="x","y","z","w"
		defaults=123456789,362436069,521288629,88675123
	return

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
		dimtype %1,vartype("struct"): \
		newmod %1,XorShift,%2,%3,%4,%5
	#modinit int _w,int _x,int _y,int _z
		if _w!=-1 :w=_w :else :w=gettime(7)+1000*(gettime(6)+60*(gettime(5)+60*(gettime(4)+24*gettime(3))))
		if _x!=-1 :x=_x :else :x=w<<13
		if _y!=-1 :y=_y :else :y=(w>>9)^(x<<6)
		if _z!=-1 :z=_z :else :z=y>>7

		dim seeds,4
		seeds(0)=double(strf("%u",x))
		seeds(1)=double(strf("%u",y))
		seeds(2)=double(strf("%u",z))
		seeds(3)=double(strf("%u",w))
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
staticNew@XorShift

#module XorShift_defaultSeed
	#define new(%1) new@XorShift \
		%1, \
		xsDefaults("w"), \
		xsDefaults("x"), \
		xsDefaults("y"), \
		xsDefaults("z")
#global