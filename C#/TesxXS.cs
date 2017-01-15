using System;
using System.Collections.Generic;
using System.Linq;
using XorShifts;

class TestXS{
	static void Main(){
		//XorShift乱数ジェネレータの初期化
		// 論文デフォルトシード
		var r_def=new XorShift.defaultSeed();
		// 固定値シード
		var r_const=new XorShift(100);
		// 時間シード
		var r=new XorShift();

		//デフォルトシード値の取得
		Console.WriteLine(">> defaults");
		Console.WriteLine(String.Join(", ",XorShift.defaults));

		//適用したシード値の取得
		Console.WriteLine(">> seeds in r");
		Console.WriteLine(String.Join(", ",r.seeds));

		//乱数の生データを取得
		Console.WriteLine(">> rand 0 to UInt32Max");
		for(int i=0;i<5;i++){
			Console.WriteLine(r_def.rand());
		}

		//0-100の乱数(100含む)を整数で取得
		Console.WriteLine(">> randInt 0 to 100");
		for(int i=0;i<5;i++){
			Console.WriteLine(r_const.randInt(0,100));
		}

		//0-1の乱数を浮遊小数点で取得
		Console.WriteLine(">> randFloat 0 to 1");
		for(int i=0;i<5;i++){
			Console.WriteLine(r.randFloat());
		}

		//静的配列のシャッフル
		//値渡しとなるので元の配列は破壊されない
		Console.WriteLine(">> shuffle Array");
		int[] a=Enumerable.Range(0,20).ToArray();
		Console.WriteLine(String.Join(", ",r.shuffle(a)));
		Console.WriteLine(String.Join(", ",a));

		//List<T>のシャッフル
		Console.WriteLine(">> shuffle List<T>");
		var b=new List<int>(Enumerable.Range(0,20));
		Console.WriteLine(String.Join(", ",r.shuffle(b)));
		Console.WriteLine(String.Join(", ",b));

		//今の乱数を回した回数
		Console.WriteLine(">> randCount in r");
		Console.WriteLine(r.randCount);
	}
}