//cmd: dmd TestXS XorShift & TestXS
import std.stdio;
import XorShift:XorShift;

void main(){
	//XorShift乱数ジェネレータの初期化
	// 論文デフォルトシード
	auto r_def=new XorShift.defaultSeed();
	// 固定値シード
	auto r_const=new XorShift(100);
	// 時間シード
	auto r=new XorShift();

	//デフォルトシード値の取得
	writeln(">> defaults");
	writeln(XorShift.defaults);

	//適用したシード値の取得
	writeln(">> seeds in r");
	writeln(r.seeds);

	//乱数の生データを取得
	writeln(">> rand 0 to UInt32Max");
	for(int i=0;i<5;i++){
		writeln(r_def.rand());
	}

	//0-100の乱数(100含む)を整数で取得
	writeln(">> randInt 0 to 100");
	for(int i=0;i<5;i++){
		writeln(r_const.randInt(0,100));
	}

	//0-1の乱数を浮遊小数点で取得
	writeln(">> randFloat 0 to 1");
	for(int i=0;i<5;i++){
		writeln(r.randFloat());
	}

	//配列のシャッフル
	//値渡しとなるので元の配列は破壊されない
	writeln(">> shuffle array");
	auto a=new int[20];
	foreach(i;0..a.length-1) a[i]=i;
	writeln(r.shuffle(a));
	writeln(a);

	//今の乱数を回した回数
	writeln(">> randCount in r");
	writeln(r.randCount);
}