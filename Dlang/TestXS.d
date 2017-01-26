//cmd: dmd TestXS XorShift & TestXS
import std.stdio;
import XorShift:XorShift;

void main(){
	//XorShift�����W�F�l���[�^�̏�����
	// �_���f�t�H���g�V�[�h
	auto r_def=new XorShift.defaultSeed();
	// �Œ�l�V�[�h
	auto r_const=new XorShift(100);
	// ���ԃV�[�h
	auto r=new XorShift();

	//�f�t�H���g�V�[�h�l�̎擾
	writeln(">> defaults");
	writeln(XorShift.defaults);

	//�K�p�����V�[�h�l�̎擾
	writeln(">> seeds in r");
	writeln(r.seeds);

	//�����̐��f�[�^���擾
	writeln(">> rand 0 to UInt32Max");
	for(int i=0;i<5;i++){
		writeln(r_def.rand());
	}

	//0-100�̗���(100�܂�)�𐮐��Ŏ擾
	writeln(">> randInt 0 to 100");
	for(int i=0;i<5;i++){
		writeln(r_const.randInt(0,100));
	}

	//0-1�̗����𕂗V�����_�Ŏ擾
	writeln(">> randFloat 0 to 1");
	for(int i=0;i<5;i++){
		writeln(r.randFloat());
	}

	//�z��̃V���b�t��
	//�l�n���ƂȂ�̂Ō��̔z��͔j�󂳂�Ȃ�
	writeln(">> shuffle array");
	auto a=new int[20];
	foreach(i;0..a.length-1) a[i]=i;
	writeln(r.shuffle(a));
	writeln(a);

	//���̗������񂵂���
	writeln(">> randCount in r");
	writeln(r.randCount);
}