#tag Class
Protected Class ArchiveException
Inherits RuntimeException
	#tag Method, Flags = &h1000
		Sub Constructor(ErrorCode As Integer)
		  Me.ErrorNumber = ErrorCode
		  Me.Message = FormatError(ErrorCode)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Archive As libarchive.Archive)
		  If Archive <> Nil And Archive.Handle <> Nil Then
		    Dim mb As MemoryBlock = archive_error_string(Archive.Handle)
		    If mb <> Nil Then Me.Message = mb.CString(0)
		    Me.ErrorNumber = Archive.LastError
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Entry As libarchive.ArchiveEntry)
		  If Entry <> Nil Then Me.Constructor(Entry.LastError)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Stream As MemoryStream)
		  If Stream <> Nil Then Me.Constructor(Stream.LastError)
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="ErrorNumber"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="RuntimeException"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Message"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="RuntimeException"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
