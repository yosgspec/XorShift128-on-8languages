Option Strict On
Imports System.Collections.Generic
Imports System.Linq

Namespace XorShifts
	Class XorShift
		Private r As IEnumerator(Of UInteger)
		Public Shared ReadOnly defaults As New Dictionary(Of String,UInteger) From {
			{"x",123456789},
			{"y",362436069},
			{"z",521288629},
			{"w",88675123}
		}
		Public ReadOnly seeds As Dictionary(Of String,UInteger)
		Public randCount As UInteger=0

		Sub New(
			Optional _w As UInteger?=Nothing,
			Optional _x As UInteger?=Nothing,
			Optional _y As UInteger?=Nothing,
			Optional _z As UInteger?=Nothing
		)
			Dim w=CUInt(If(_w IsNot Nothing,_w,CUInt(Environment.TickCount)))
			Dim x=CUInt(If(_x IsNot Nothing,_x,w<<13))
			Dim y=CUInt(If(_y IsNot Nothing,_y,w>>9 Xor x<<6))
			Dim z=CUInt(If(_z IsNot Nothing,_z,y>>7))
			seeds=New Dictionary(Of String,UInteger) From {
				{"x",x},{"y",y},{"z",z},{"w",w}
			}
			r=randGen(w,x,y,z)
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

		PubLic Class defaultSeed
			Inherits XorShift
			Sub New()
				MyBase.New(
				defaults("w"),
				defaults("x"),
				defaults("y"),
				defaults("z")
				)
			End Sub
		End Class
	End Class
End Namespace