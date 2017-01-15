using System;
using System.Collections.Generic;
using System.Linq;
using XorShifts;

class TestXS{
	static void Main(){
		//XorShift�����W�F�l���[�^�̏�����
		// �_���f�t�H���g�V�[�h
		var r_def=new XorShift.defaultSeed();
		// �Œ�l�V�[�h
		var r_const=new XorShift(100);
		// ���ԃV�[�h
		var r=new XorShift();

		//�f�t�H���g�V�[�h�l�̎擾
		Console.WriteLine(">> defaults");
		Console.WriteLine(String.Join(", ",XorShift.defaults));

		//�K�p�����V�[�h�l�̎擾
		Console.WriteLine(">> seeds in r");
		Console.WriteLine(String.Join(", ",r.seeds));

		//�����̐��f�[�^���擾
		Console.WriteLine(">> rand 0 to UInt32Max");
		for(int i=0;i<5;i++){
			Console.WriteLine(r_def.rand());
		}

		//0-100�̗���(100�܂�)�𐮐��Ŏ擾
		Console.WriteLine(">> randInt 0 to 100");
		for(int i=0;i<5;i++){
			Console.WriteLine(r_const.randInt(0,100));
		}

		//0-1�̗����𕂗V�����_�Ŏ擾
		Console.WriteLine(">> randFloat 0 to 1");
		for(int i=0;i<5;i++){
			Console.WriteLine(r.randFloat());
		}

		//�ÓI�z��̃V���b�t��
		//�l�n���ƂȂ�̂Ō��̔z��͔j�󂳂�Ȃ�
		Console.WriteLine(">> shuffle Array");
		int[] a=Enumerable.Range(0,20).ToArray();
		Console.WriteLine(String.Join(", ",r.shuffle(a)));
		Console.WriteLine(String.Join(", ",a));

		//List<T>�̃V���b�t��
		Console.WriteLine(">> shuffle List<T>");
		var b=new List<int>(Enumerable.Range(0,20));
		Console.WriteLine(String.Join(", ",r.shuffle(b)));
		Console.WriteLine(String.Join(", ",b));

		//���̗������񂵂���
		Console.WriteLine(">> randCount in r");
		Console.WriteLine(r.randCount);
	}
}