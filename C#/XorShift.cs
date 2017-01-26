using System;
using System.Collections.Generic;

namespace XorShifts{
	class XorShift{
		private IEnumerator<uint> r;
		public static readonly Dictionary<string,uint> defaults=new Dictionary<string,uint>(){
			{"x",123456789},
			{"y",362436069},
			{"z",521288629},
			{"w",88675123}
		};
		public readonly Dictionary<string,uint> seeds;
		public uint randCount=0;

		public XorShift(uint? _w=null,uint? _x=null,uint? _y=null,uint? _z=null){
			uint w=_w ?? (uint)Environment.TickCount;
			uint x=_x ?? w<<13;
			uint y=_y ?? (w>>9)^(x<<6);
			uint z=_z ?? y>>7;
			seeds=new Dictionary<string,uint>(){
				{"x",x},{"y",y},{"z",z},{"w",w}
			};
			r=randGen(w,x,y,z);
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

		public class defaultSeed:XorShift{
			public defaultSeed():base(
				defaults["w"],
				defaults["x"],
				defaults["y"],
				defaults["z"]
			){}
		}
	}
}