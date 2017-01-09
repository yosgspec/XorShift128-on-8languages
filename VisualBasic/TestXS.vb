Option Strict On
Imports System.Console
Imports System.Collections.Generic
Imports System.Linq
Imports XorShifts

Module TestXS
	Sub Main()
		'乱数の生データを取得
		Dim rW As new XorShift(XorShift.undefaultW)
		WriteLine(">> rand 0 to UInt32Max")
		For i=0 To 5-1
			WriteLine(rW.rand())
		Next

		'0-100の乱数(100含む)を整数で取得
		Dim r As new XorShift()
		WriteLine(">> randInt 0 to 100")
		For i=0 To 5-1
			WriteLine(r.randInt(0,100))
		Next

		'0-1の乱数を浮遊小数点で取得
		WriteLine(">> randFloat 0 to 1")
		For i=0 To 5-1
			WriteLine(r.randFloat())
		Next

		'静的配列のシャッフル
		WriteLine(">> shuffle Array")
		Dim a As Integer()=Enumerable.Range(0,20).ToArray()
		WriteLine(String.Join(", ",r.shuffle(a)))
		WriteLine(String.Join(", ",a))

		'List(Of T)のシャッフル
		WriteLine(">> shuffle List(Of T)")
		Dim b As New List(Of Integer)(Enumerable.Range(0,20))
		WriteLine(String.Join(", ",r.shuffle(b)))
		WriteLine(String.Join(", ",b))

		'デフォルトのシード値を取得
		WriteLine(">> defaults")
		WriteLine(XorShift.defaultX)
		WriteLine(XorShift.defaultY)
		WriteLine(XorShift.defaultZ)
		WriteLine(XorShift.undefaultW)

		'今の乱数に与えたシード値初期値(wのみ)
		WriteLine(">> seedW")
		WriteLine(r.seedW)

		'今の乱数を回した回数
		WriteLine(">> randCount")
		WriteLine(r.randCount)
	End Sub
End Module
