Option Strict On
Imports System.Console
Imports System.Collections.Generic
Imports System.Linq
Imports XorShifts

Module TestXS
	Sub Main()
		'XorShift�����W�F�l���[�^�̏�����
		' �_���f�t�H���g�V�[�h
		Dim r_def As New XorShift.defaultSeed()
		' �Œ�l�V�[�h
		Dim r_const As New XorShift(100)
		' ���ԃV�[�h
		Dim r As New XorShift()

		'�f�t�H���g�V�[�h�l�̎擾
		WriteLine(">> defaults")
		WriteLine(String.Join(", ",XorShift.defaults))

		'�K�p�����V�[�h�l�̎擾
		WriteLine(">> seeds in r")
		WriteLine(String.Join(", ",r.seeds))

		'�����̐��f�[�^���擾
		WriteLine(">> rand 0 to UInt32Max")
		For i=0 To 5-1
			WriteLine(r_def.rand())
		Next

		'0-100�̗���(100�܂�)�𐮐��Ŏ擾
		WriteLine(">> randInt 0 to 100")
		For i=0 To 5-1
			WriteLine(r_const.randInt(0,100))
		Next

		'0-1�̗����𕂗V�����_�Ŏ擾
		WriteLine(">> randFloat 0 to 1")
		For i=0 To 5-1
			WriteLine(r.randFloat())
		Next

		'�ÓI�z��̃V���b�t��
		'�l�n���ƂȂ�̂Ō��̔z��͔j�󂳂�Ȃ�
		WriteLine(">> shuffle Array")
		Dim a As Integer()=Enumerable.Range(0,20).ToArray()
		WriteLine(String.Join(", ",r.shuffle(a)))
		WriteLine(String.Join(", ",a))

		'List(Of T)�̃V���b�t��
		WriteLine(">> shuffle List(Of T)")
		Dim b As New List(Of Integer)(Enumerable.Range(0,20))
		WriteLine(String.Join(", ",r.shuffle(b)))
		WriteLine(String.Join(", ",b))

		'���̗������񂵂���
		WriteLine(">> randCount in r")
		WriteLine(r.randCount)
	End Sub
End Module