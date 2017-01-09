#include <iostream>
#include "XorShift.cpp"

using namespace std;
using namespace XorShifts;

int main(){
	//乱数の生データを取得
	auto rW=XorShift(XorShift::undefaultW);
	cout<<">> rand 0 to UInt32Max"<<endl;
	for(int i=0;i<5;i++){
		cout<<rW.rand()<<endl;
	}

	//0-100の乱数(100含む)を整数で取得
	cout<<">> randInt 0 to 100"<<endl;
	auto r=XorShift(XorShift::undefaultW);
	for(int i=0;i<5;i++){
		cout<<r.randInt(0,100)<<endl;
	}

	//0-1の乱数を浮遊小数点で取得
	cout<<">> randFloat 0 to 1"<<endl;
	for(int i=0;i<5;i++){
		cout<<r.randFloat()<<endl;
	}

	//静的配列のシャッフル
	cout<<">> shuffle array"<<endl;
	int a[20],aCopy[20];
	int* aRand;
	for(int i=0;i<20;i++) a[i]=i;
	int aLength=sizeof(a)/sizeof(a[0]);

	aRand=r.shuffle(a,aCopy,aLength);
	for(int i=0;i<aLength;i++) cout<<aRand[i]<<", ";
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

	//デフォルトのシード値を取得
	cout<<">> defaults"<<endl;
	cout<<XorShift::defaultX<<endl;
	cout<<XorShift::defaultY<<endl;
	cout<<XorShift::defaultZ<<endl;
	cout<<XorShift::undefaultW<<endl;

	//今の乱数に与えたシード値初期値(wのみ)
	cout<<">> seedW"<<endl;
	cout<<r.seedW<<endl;

	//今の乱数を回した回数
	cout<<">> randCount"<<endl;
	cout<<r.randCount<<endl;
}