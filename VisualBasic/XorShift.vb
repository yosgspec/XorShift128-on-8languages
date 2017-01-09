Option Strict On
Imports System.Console
Imports System.Collections.Generic
Imports System.Linq

Namespace XorShifts
	Class XorShift
		Private r As IEnumerator(Of UInteger)
		Public Const defaultX=123456789UI
		Public Const defaultY=362436069UI
		Public Const defaultZ=521288629UI
		Public Const undefaultW=88675123UI
		Public ReadOnly seedW As UInteger
		Public randCount As UInteger=0

		Sub New(
			Optional w As UInteger?=Nothing,
			Optional x As UInteger=defaultX,
			Optional y As UInteger=defaultY,
			Optional z As UInteger=defaultZ
		)
			seedW=If(w IsNot Nothing,CUInt(w),CUInt((1103515245UI*Environment.TickCount+12345UI) mod &H7FFFFFFFUI))
			r=randGen(seedW,x,y,z)
		End Sub

		Public Iterator Function randGen(w As UInteger,x As UInteger,y As UInteger,z As UInteger) As IEnumerator(Of UInteger)
			Dim t As UInteger
			Do
				t=x Xor (x<<11)
				x=y
				y=z
				z=w
				w=(w Xor (w>>19)) Xor (t Xor (t>>8))
				Yield w
			Loop
		End Function

		Public Function rand() As UInteger
			randCount+=1UI
			r.MoveNext()
			Return r.Current
		End Function

		Public Function randInt(Optional min As Integer=0,Optional max As Integer=&H7FFFFFFFI) As Integer
			Return CInt(rand() mod (CUInt(max)-min+1)+min)
		End Function

		Public Function randFloat(Optional min As Single=0,Optional max As Single=1) As Single
			Return CSng((rand() mod &HFFFFUI)/&HFFFFUI*(max-min)+min)
		End Function

		Public Function shuffle(Of T)(_arr As T()) As T()
			Dim arr=CType(_arr.Clone(),T())
			For i=0 To arr.Length-2
				Dim r As Integer=randInt(i,arr.Length-1)
				Dim tmp As T=arr(i)
				arr(i)=arr(r)
				arr(r)=tmp
			Next
			Return arr
		End Function

		Public Function shuffle(Of T)(_arr As List(Of T)) As List(Of T)
			Dim arr As New List(Of T)(_arr)
			For i=0 To arr.Count-2
				Dim r As Integer=randInt(i,arr.Count-1)
				Dim tmp As T=arr(i)
				arr(i)=arr(r)
				arr(r)=tmp
			Next
			Return arr
		End Function
	End Class
End Namespace