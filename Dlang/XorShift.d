module XorShift;

import std.datetime;
import std.concurrency;

static public class XorShift{
private:
	Generator!uint r;

public:
	static immutable uint[string] defaults;
	static this(){
		defaults=[
			"x":123456789,
			"y":362436069,
			"z":521288629,
			"w":88675123
		];
	}
	immutable uint[string] seeds;
	uint randCount=0;

	this(
		uint w=cast(uint)Clock.currStdTime(),
		uint x=0x7FFFFFF7,uint y=0x7FFFFFF7,uint z=0x7FFFFFF7
	){
		if(x==0x7FFFFFF7) x=w<<13;
		if(y==0x7FFFFFF7) y=(w>>9)^(x<<6);
		if(z==0x7FFFFFF7) z=y>>7;
		seeds=["x":x,"y":y,"z":z,"w":w];
		r=randGen(w,x,y,z);
	}

	Generator!uint function(uint,uint,uint,uint) randGen=(w,x,y,z)=>new Generator!uint((){
		yield(w);
		uint t;
		for(;;){
			t=x^(x<<11);
			x=y;
			y=z;
			z=w;
			yield(w=(w^(w>>19))^(t^(t>>8)));
		}
	});

	uint rand(){
		randCount++;
		r.popFront();
		return r.front;
	}

	int randInt(int min=0,int max=0x7FFFFFFF){
		return rand()%(max-min+1)+min;
	}

	float randFloat(float min=0,float max=1){
		return cast(float)(rand()%0xFFFF)/0xFFFF*(max-min)+min;
	}

	template shuffle(T){
		T[] shuffle(T[] _arr){
			auto arr=new T[_arr.length];
			arr[]=_arr;
			for(int i=0;i<=arr.length-2;i++){
				int r=randInt(i,arr.length-1);
				T tmp=arr[i];
				arr[i]=arr[r];
				arr[r]=tmp;
			}
			return arr;
		}
	}

	static class defaultSeed:XorShift{
	public:
		this(){
			super(
				XorShift.defaults["w"],
				XorShift.defaults["x"],
				XorShift.defaults["y"],
				XorShift.defaults["z"]
			);
		}
	}
}