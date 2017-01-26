var XorShift=function(_w,_x,_y,_z){
	var x,y,z,w;
	this.seeds={};
	this.randCount=0;

	w=_w!==undefined? _w: new Date().getTime();
	x=_x!==undefined? _x: w<<13;
	y=_y!==undefined? _y: (w>>>9)^(x<<6);
	z=_z!==undefined? _z: y>>>7;
	this.seeds={x:x>>>0,y:y>>>0,z:z>>>0,w:w>>>0};

	this.rand=function(){
		this.randCount=0|this.randCount+1;
		var t=x^(x<<11);
		x=y;
		y=z;
		z=w;
		return w=((w^(w>>>19))^(t^(t>>>8)))>>>0;
	};
};

XorShift.prototype.randInt=function(min,max){
	if(min===undefined) min=0;
	if(max===undefined) max=0x7FFFFFFF;
	return 0|this.rand()%(max+1-min)+min;
};

XorShift.prototype.randFloat=function(min,max){
	if(min===undefined) min=0;
	if(max===undefined) max=1;
	return this.rand()%0xFFFF/0xFFFF*(max-min)+min;
};

XorShift.prototype.shuffle=function(_arr){
	var arr=_arr.concat();
	for(var i=0;i<=arr.length-2;i=0|i+1){
		var r=this.randInt(i,arr.length-1);
		var tmp=arr[i];
		arr[i]=arr[r];
		arr[r]=tmp;
	};
	return arr;
};

XorShift.defaults={
	x:123456789,
	y:362436069,
	z:521288629,
	w:88675123
};

XorShift.defaultSeed=function(){
	XorShift.call(this,
		XorShift.defaults["w"],
		XorShift.defaults["x"],
		XorShift.defaults["y"],
		XorShift.defaults["z"]
	);
};