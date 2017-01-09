using System;
using System.Collections.Generic;
using System.Linq;
using XorShifts;

class TestXS{
	static void Main(){
		//乱数の生データを取得
		var rW=new XorShift(XorShift.undefaultW);
		Console.WriteLine(">> rand 0 to UInt32Max");
		for(int i=0;i<5;i++){
			Console.WriteLine(rW.rand());
		}

		//0-100の乱数(100含む)を整数で取得
		var r=new XorShift();
		Console.WriteLine(">> randInt 0 to 100");
		for(int i=0;i<5;i++){
			Console.WriteLine(r.randInt(0,100));
		}

		//0-1の乱数を浮遊小数点で取得
		Console.WriteLine(">> randFloat 0 to 1");
		for(int i=0;i<5;i++){
			Console.WriteLine(r.randFloat());
		}

		//静的配列のシャッフル
		Console.WriteLine(">> shuffle Array");
		int[] a=Enumerable.Range(0,20).ToArray();
		Console.WriteLine(String.Join(", ",r.shuffle(a)));
		Console.WriteLine(String.Join(", ",a));

		//List<T>のシャッフル
		Console.WriteLine(">> shuffle List<T>");
		var b=new List<int>(Enumerable.Range(0,20));
		Console.WriteLine(String.Join(", ",r.shuffle(b)));
		Console.WriteLine(String.Join(", ",b));

		//デフォルトのシード値を取得
		Console.WriteLine(">> defaults");
		Console.WriteLine(XorShift.defaultX);
		Console.WriteLine(XorShift.defaultY);
		Console.WriteLine(XorShift.defaultZ);
		Console.WriteLine(XorShift.undefaultW);

		//今の乱数に与えたシード値初期値(wのみ)
		Console.WriteLine(">> seedW");
		Console.WriteLine(r.seedW);

		//今の乱数を回した回数
		Console.WriteLine(">> randCount");
		Console.WriteLine(r.randCount);
	}
}
