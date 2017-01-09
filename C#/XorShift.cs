using System;
using System.Collections.Generic;

namespace XorShifts{
	class XorShift{
		private IEnumerator<uint> r;
		public const uint defaultX=123456789;
		public const uint defaultY=362436069;
		public const uint defaultZ=521288629;
		public const uint undefaultW=88675123;
		public readonly uint seedW;
		public uint randCount=0;

		public XorShift(
			uint? w=null,
			uint x=defaultX,
			uint y=defaultY,
			uint z=defaultZ
		){
			seedW=w!=null?(uint)w:(uint)(1103515245*Environment.TickCount+12345)%0x7FFFFFFF;
			r=randGen(seedW,x,y,z);
		}

		public IEnumerator<uint> randGen(uint w,uint x,uint y,uint z){
			uint t;
			for(;;){
				t=x^(x<<11);
				x=y;
				y=z;
				z=w;
				yield return w=(w^(w>>19))^(t^(t>>8));
			}
		}

		public uint rand(){
			randCount++;
			r.MoveNext();
			return r.Current;
		}

		public int randInt(int min=0,int max=0x7FFFFFFF){
			return (int)(rand()%(max-min+1))+min;
		}

		public float randFloat(float min=0,float max=1){
			return (float)(rand()%0xFFFF)/0xFFFF*(max-min)+min;
		}

		public T[] shuffle<T>(T[] _arr){
			var arr=(T[])_arr.Clone();
			for(int i=0;i<=arr.Length-2;i++){
				int r=randInt(i,arr.Length-1);
				T tmp=arr[i];
				arr[i]=arr[r];
				arr[r]=tmp;
			}
			return arr;
		}

		public List<T> shuffle<T>(List<T> _arr){
			var arr=new List<T>(_arr);
			for(int i=0;i<=arr.Count-2;i++){
				int r=randInt(i,arr.Count-1);
				T tmp=arr[i];
				arr[i]=arr[r];
				arr[r]=tmp;
			}
			return arr;
		}
	}
}