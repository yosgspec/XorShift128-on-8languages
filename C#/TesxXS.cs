using System;
using System.Collections.Generic;
using System.Linq;
using XorShifts;

class TestXS{
	static void Main(){
		//�����̐��f�[�^���擾
		var rW=new XorShift(XorShift.undefaultW);
		Console.WriteLine(">> rand 0 to UInt32Max");
		for(int i=0;i<5;i++){
			Console.WriteLine(rW.rand());
		}

		//0-100�̗���(100�܂�)�𐮐��Ŏ擾
		var r=new XorShift();
		Console.WriteLine(">> randInt 0 to 100");
		for(int i=0;i<5;i++){
			Console.WriteLine(r.randInt(0,100));
		}

		//0-1�̗����𕂗V�����_�Ŏ擾
		Console.WriteLine(">> randFloat 0 to 1");
		for(int i=0;i<5;i++){
			Console.WriteLine(r.randFloat());
		}

		//�ÓI�z��̃V���b�t��
		Console.WriteLine(">> shuffle Array");
		int[] a=Enumerable.Range(0,20).ToArray();
		Console.WriteLine(String.Join(", ",r.shuffle(a)));
		Console.WriteLine(String.Join(", ",a));

		//List<T>�̃V���b�t��
		Console.WriteLine(">> shuffle List<T>");
		var b=new List<int>(Enumerable.Range(0,20));
		Console.WriteLine(String.Join(", ",r.shuffle(b)));
		Console.WriteLine(String.Join(", ",b));

		//�f�t�H���g�̃V�[�h�l���擾
		Console.WriteLine(">> defaults");
		Console.WriteLine(XorShift.defaultX);
		Console.WriteLine(XorShift.defaultY);
		Console.WriteLine(XorShift.defaultZ);
		Console.WriteLine(XorShift.undefaultW);

		//���̗����ɗ^�����V�[�h�l�����l(w�̂�)
		Console.WriteLine(">> seedW");
		Console.WriteLine(r.seedW);

		//���̗������񂵂���
		Console.WriteLine(">> randCount");
		Console.WriteLine(r.randCount);
	}
}
