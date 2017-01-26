#include <iostream>
#include "XorShift.cpp"

using namespace std;
using namespace XorShifts;

int main(){
	//XorShift�����W�F�l���[�^�̏�����
	// �_���f�t�H���g�V�[�h
	auto r_def=XorShift::defaultSeed();
	// �Œ�l�V�[�h
	auto r_const=XorShift(100);
	// ���ԃV�[�h
	auto r=XorShift();

	//�f�t�H���g�V�[�h�l�̎擾
	cout<<">> defaults"<<endl;
	cout<<"x:"<<XorShift::defaults.x<<endl;
	cout<<"y:"<<XorShift::defaults.y<<endl;
	cout<<"z:"<<XorShift::defaults.z<<endl;
	cout<<"w:"<<XorShift::defaults.w<<endl;

	//�K�p�����V�[�h�l�̎擾
	cout<<">> seeds in r"<<endl;
	cout<<"x:"<<r.seeds.x<<endl;
	cout<<"y:"<<r.seeds.y<<endl;
	cout<<"z:"<<r.seeds.z<<endl;
	cout<<"w:"<<r.seeds.w<<endl;

	//�����̐��f�[�^���擾
	cout<<">> rand 0 to UInt32Max"<<endl;
	for(int i=0;i<5;i++){
		cout<<r_def.rand()<<endl;
	}

	//0-100�̗���(100�܂�)�𐮐��Ŏ擾
	cout<<">> randInt 0 to 100"<<endl;
	for(int i=0;i<5;i++){
		cout<<r_const.randInt(0,100)<<endl;
	}

	//0-1�̗����𕂗V�����_�Ŏ擾
	cout<<">> randFloat 0 to 1"<<endl;
	for(int i=0;i<5;i++){
		cout<<r.randFloat()<<endl;
	}

	//�ÓI�z��̃V���b�t��
	//�l�n���ƂȂ�̂Ō��̔z��͔j�󂳂�Ȃ�
	cout<<">> shuffle array"<<endl;
	int a[20],a_copy[20];
	for(int i=0;i<20;i++) a[i]=i;
	int a_length=sizeof(a)/sizeof(a[0]);

	int* a_rand=r.shuffle(a,a_copy,a_length);
	for(int i=0;i<a_length;i++) cout<<a_rand[i]<<", ";
	cout<<endl;
	for(auto val:a) cout<<val<<", ";
	cout<<endl;

	//vector<T>�̃V���b�t��
	cout<<">> shuffle vector<T>"<<endl;
	vector<int> b;
	for(int i=0;i<20;i++) b.push_back(i);

	for(auto val:r.shuffle(b)) cout<<val<<", ";
	cout<<endl;
	for(auto val:b) cout<<val<<", ";
	cout<<endl;

	//���̗������񂵂���
	cout<<">> randCount in r"<<endl;
	cout<<r.randCount<<endl;
}