"use strict";

module.exports=(()=>{
	const r=Symbol();

	class XorShift{
		constructor(w,x,y,z){
			if(w==="default"){
				[w,x,y,z]=[XorShift.defaultW,XorShift.defaultX,XorShift.defaultY,XorShift.defaultZ]
			}
			else {
				if(w===undefined) w=0|(1103515245*(Date.now()&0xFFFF<<10)+12345)%0x7FFFFFFF;
				if(x===undefined) x=0|(w<<13);
				if(y===undefined) y=0|((w>>9)^(x<<6));
				if(z===undefined) z=0|(y>>7);
			}
			this.seedW=w;
			Object.defineProperty(this,"seedW",{writable:false});
			this.randCount=0;
			this[r]=this.randGen(w,x,y,z);
		}

		*randGen(w,x,y,z){
			var t;
			for(;;){
				t=x^(x<<11);
				x=y;
				y=z;
				z=w;
				yield w=((w^(w>>>19))^(t^(t>>>8)))>>>0;
			}
		}

		rand(){
			this.randCount=0|this.randCount+1;
			return this[r].next().value;
		}

		randInt(min=0,max=0x7FFFFFFF){
			return 0|this.rand()%(max+1-min)+min;
		}

		randFloat(min=0,max=1){
			return Math.fround(this.rand()%0xFFFF/0xFFFF)*(max-min)+min;
		}

		shuffle(_arr){
			var arr=_arr.concat();
			for(let i=0;i<=arr.length-2;i=0|i+1){
				let r=this.randInt(i,arr.length-1);
				let tmp=arr[i];
				arr[i]=arr[r];
				arr[r]=tmp;
			}
			return arr;
		}
	}
	XorShift.defaultX=123456789;
	XorShift.defaultY=362436069;
	XorShift.defaultZ=521288629;
	XorShift.undefaultW=88675123;
	Object.freeze(XorShift);
	return XorShift;
})();