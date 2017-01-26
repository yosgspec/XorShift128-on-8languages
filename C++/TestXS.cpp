#include <iostream>
#include "XorShift.cpp"

using namespace std;
using namespace XorShifts;

int main(){
	//XorShift乱数ジェネレータの初期化
	// 論文デフォルトシード
	auto r_def=XorShift::defaultSeed();
	// 固定値シード
	auto r_const=XorShift(100);
	// 時間シード
	auto r=XorShift();

	//デフォルトシード値の取得
	cout<<">> defaults"<<endl;
	cout<<"x:"<<XorShift::defaults.x<<endl;
	cout<<"y:"<<XorShift::defaults.y<<endl;
	cout<<"z:"<<XorShift::defaults.z<<endl;
	cout<<"w:"<<XorShift::defaults.w<<endl;

	//適用したシード値の取得
	cout<<">> seeds in r"<<endl;
	cout<<"x:"<<r.seeds.x<<endl;
	cout<<"y:"<<r.seeds.y<<endl;
	cout<<"z:"<<r.seeds.z<<endl;
	cout<<"w:"<<r.seeds.w<<endl;

	//乱数の生データを取得
	cout<<">> rand 0 to UInt32Max"<<endl;
	for(int i=0;i<5;i++){
		cout<<r_def.rand()<<endl;
	}

	//0-100の乱数(100含む)を整数で取得
	cout<<">> randInt 0 to 100"<<endl;
	for(int i=0;i<5;i++){
		cout<<r_const.randInt(0,100)<<endl;
	}

	//0-1の乱数を浮遊小数点で取得
	cout<<">> randFloat 0 to 1"<<endl;
	for(int i=0;i<5;i++){
		cout<<r.randFloat()<<endl;
	}

	//静的配列のシャッフル
	//値渡しとなるので元の配列は破壊されない
	cout<<">> shuffle array"<<endl;
	int a[20],a_copy[20];
	for(int i=0;i<20;i++) a[i]=i;
	int a_length=sizeof(a)/sizeof(a[0]);

	int* a_rand=r.shuffle(a,a_copy,a_length);
	for(int i=0;i<a_length;i++) cout<<a_rand[i]<<", ";
	cout<<endl;
	for(auto val:a) cout<<val<<", ";
	cout<<endl;

	//vector<T>のシャッフル
	cout<<">> shuffle vector<T>"<<endl;
	vector<int> b;
	for(int i=0;i<20;i++) b.push_back(i);

	for(auto val:r.shuffle(b)) cout<<val<<", ";
	cout<<endl;
	for(auto val:b) cout<<val<<", ";
	cout<<endl;

	//今の乱数を回した回数
	cout<<">> randCount in r"<<endl;
	cout<<r.randCount<<endl;
}