Option Strict On
Imports System.Console
Imports System.Collections.Generic
Imports System.Linq
Imports XorShifts

Module TestXS
	Sub Main()
		'�����̐��f�[�^���擾
		Dim rW As new XorShift(XorShift.undefaultW)
		WriteLine(">> rand 0 to UInt32Max")
		For i=0 To 5-1
			WriteLine(rW.rand())
		Next

		'0-100�̗���(100�܂�)�𐮐��Ŏ擾
		Dim r As new XorShift()
		WriteLine(">> randInt 0 to 100")
		For i=0 To 5-1
			WriteLine(r.randInt(0,100))
		Next

		'0-1�̗����𕂗V�����_�Ŏ擾
		WriteLine(">> randFloat 0 to 1")
		For i=0 To 5-1
			WriteLine(r.randFloat())
		Next

		'�ÓI�z��̃V���b�t��
		WriteLine(">> shuffle Array")
		Dim a As Integer()=Enumerable.Range(0,20).ToArray()
		WriteLine(String.Join(", ",r.shuffle(a)))
		WriteLine(String.Join(", ",a))

		'List(Of T)�̃V���b�t��
		WriteLine(">> shuffle List(Of T)")
		Dim b As New List(Of Integer)(Enumerable.Range(0,20))
		WriteLine(String.Join(", ",r.shuffle(b)))
		WriteLine(String.Join(", ",b))

		'�f�t�H���g�̃V�[�h�l���擾
		WriteLine(">> defaults")
		WriteLine(XorShift.defaultX)
		WriteLine(XorShift.defaultY)
		WriteLine(XorShift.defaultZ)
		WriteLine(XorShift.undefaultW)

		'���̗����ɗ^�����V�[�h�l�����l(w�̂�)
		WriteLine(">> seedW")
		WriteLine(r.seedW)

		'���̗������񂵂���
		WriteLine(">> randCount")
		WriteLine(r.randCount)
	End Sub
End Module
