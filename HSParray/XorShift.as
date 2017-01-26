#module XorShift
	#enum x=0
	#enum y
	#enum z
	#enum w
	#enum randCount

	#define global xsX x@XorShift
	#define global xsY y@XorShift
	#define global xsZ z@XorShift
	#define global xsW w@XorShift
	#define global xsRandCount randCount@XorShift
	#define global xsSeedKeys seedKeys@XorShift
	#define global xsDefaults defaults@XorShift

	#deffunc local staticNew
		seedKeys="x","y","z","w"
		defaults=123456789,362436069,521288629,88675123
	return

	#define new(%1,%2=-1,%3=-1,%4=-1,%5=-1) \
		dim %1,5: \
		dim %1_seeds,4: \
		__new@XorShift %1,%1_seeds,%2,%3,%4,%5
	#deffunc local __new array this,array seeds,int _w,int _x,int _y,int _z
		if _w!=-1 :this.w=_w :else :this.w=gettime(7)+1000*(gettime(6)+60*(gettime(5)+60*(gettime(4)+24*gettime(3))))
		if _x!=-1 :this.x=_x :else :this.x=this.w<<13
		if _y!=-1 :this.y=_y :else :this.y=(this.w>>9)^(this.x<<6)
		if _z!=-1 :this.z=_z :else :this.z=this.y>>7
		seeds.x=double(strf("%u",this.x))
		seeds.y=double(strf("%u",this.y))
		seeds.z=double(strf("%u",this.z))
		seeds.w=double(strf("%u",this.w))
		this.randCount=0
	return

	#defcfunc xsRand array this
		this.randCount++
		t=this.x^(this.x<<11)
		this.x=this.y
		this.y=this.z
		this.z=this.w
		this.w=(this.w^(this.w>>19&$1FFF))^(t^(t>>8&$FFFFFF))
	return double(strf("%u",this.w))

	#define global ctype xsRandInt(%1,%2=0,%3=$7FFFFFFF) randInt@XorShift(%1,%2,%3)
	#defcfunc local randInt array this,int min,int max
		return int(xsRand(this)\(max+1-min)+min)

	#define global ctype xsRandFloat(%1,%2=0,%3=1) randFloat@XorShift(%1,%2,%3)
	#defcfunc local randFloat array this,double min,double max
		return xsRand(this)\$FFFF/$FFFF*(max-min)+min

	#define global xsShuffle(%1,%2,%3) %tshuffle \
		%i=length(%2) :\
		dimtype %3,vartype(%2(0)),%p :\
		foreach %3: %3(cnt)=%2(cnt): loop :\
		shuffle@XorShift %1,%o,%3

	#deffunc local shuffle array this,var arrLength,array arr
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
		xsDefaults.xsW, \
		xsDefaults.xsX, \
		xsDefaults.xsY, \
		xsDefaults.xsZ
#global