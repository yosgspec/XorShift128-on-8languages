module XorShift;

import std.datetime;
import std.concurrency;

static public class XorShift{
private:
	Generator!uint r;

public:
	static uint defaultX=123456789;
	static uint defaultY=362436069;
	static uint defaultZ=521288629;
	static uint undefaultW=88675123;
	uint seedW;
	uint randCount=0;

	this(
		uint w=cast(uint)(1103515245*Clock.currStdTime()+12345)%0x7FFFFFFF,
		uint x=defaultX,
		uint y=defaultY,
		uint z=defaultZ
	){
		seedW=w;
		r=randGen(w,x,y,z);
	}

	Generator!uint function(uint,uint,uint,uint) randGen=(w,x,y,z)=>new Generator!uint((){
		yield(w);
		uint x=123456789;
		uint y=362436069;
		uint z=521288629;
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

	public template shuffle(T){
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
}