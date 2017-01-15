Option Strict On
Imports System.Console
Imports System.Collections.Generic
Imports System.Linq
Imports XorShifts

Module TestXS
	Sub Main()
		'XorShift乱数ジェネレータの初期化
		' 論文デフォルトシード
		Dim r_def As New XorShift.defaultSeed()
		' 固定値シード
		Dim r_const As New XorShift(100)
		' 時間シード
		Dim r As New XorShift()

		'デフォルトシード値の取得
		WriteLine(">> defaults")
		WriteLine(String.Join(", ",XorShift.defaults))

		'適用したシード値の取得
		WriteLine(">> seeds in r")
		WriteLine(String.Join(", ",r.seeds))

		'乱数の生データを取得
		WriteLine(">> rand 0 to UInt32Max")
		For i=0 To 5-1
			WriteLine(r_def.rand())
		Next

		'0-100の乱数(100含む)を整数で取得
		WriteLine(">> randInt 0 to 100")
		For i=0 To 5-1
			WriteLine(r_const.randInt(0,100))
		Next

		'0-1の乱数を浮遊小数点で取得
		WriteLine(">> randFloat 0 to 1")
		For i=0 To 5-1
			WriteLine(r.randFloat())
		Next

		'静的配列のシャッフル
		'値渡しとなるので元の配列は破壊されない
		WriteLine(">> shuffle Array")
		Dim a As Integer()=Enumerable.Range(0,20).ToArray()
		WriteLine(String.Join(", ",r.shuffle(a)))
		WriteLine(String.Join(", ",a))

		'List(Of T)のシャッフル
		WriteLine(">> shuffle List(Of T)")
		Dim b As New List(Of Integer)(Enumerable.Range(0,20))
		WriteLine(String.Join(", ",r.shuffle(b)))
		WriteLine(String.Join(", ",b))

		'今の乱数を回した回数
		WriteLine(">> randCount in r")
		WriteLine(r.randCount)
	End Sub
End Module