//cmd: dmd TestXS XorShift & TestXS
import std.stdio;
import XorShift:XorShift;

void main(){
	//乱数の生データを取得
	auto rW=new XorShift(XorShift.undefaultW);
	writeln(">> rand 0 to UInt32Max");
	for(int i=0;i<5;i++){
		writeln(rW.rand());
	}

	//0-100の乱数(100含む)を整数で取得
	auto r=new XorShift(XorShift.undefaultW);
	writeln(">> randInt 0 to 100");
	for(int i=0;i<5;i++){
		writeln(r.randInt(0,100));
	}

	//0-1の乱数を浮遊小数点で取得
	writeln(">> randFloat 0 to 1");
	for(int i=0;i<5;i++){
		writeln(r.randFloat());
	}

	//配列のシャッフル
	writeln(">> shuffle array");
	auto a=new int[20];
	foreach(i;0..a.length-1) a[i]=i;
	writeln(r.shuffle(a));
	writeln(a);

	//デフォルトのシード値を取得
	writeln(">> defaults");
	writeln(XorShift.defaultX);
	writeln(XorShift.defaultY);
	writeln(XorShift.defaultZ);
	writeln(XorShift.undefaultW);

	//今の乱数に与えたシード値初期値(wのみ)
	writeln(">> seedW");
	writeln(r.seedW);

	//今の乱数を回した回数
	writeln(">> randCount");
	writeln(r.randCount);
}