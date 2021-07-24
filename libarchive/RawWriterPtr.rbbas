#tag Class
Private Class RawWriterPtr
Inherits libarchive.Writers.RawWriter
	#tag Method, Flags = &h0
		Sub Close()
		  mArchive = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(TrueWriter As libarchive.ArchiveWriter)
		  ' This class allows any kind of ArchiveWriter to be seen as a RawWriter object
		  ' representing the current entry in the archive.
		  
		  mArchive = TrueWriter.Handle
		  mHeaderWritten = TrueWriter.mHeaderWritten
		  mIsOpen = TrueWriter.mIsOpen
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Create()
		  If IsOpen Then
		    mLastError = ERR_TOO_LATE
		    Raise New ArchiveException(Me)
		  End If
		  
		  mIsOpen = True
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteEntryFinished()
		  Super.WriteEntryFinished()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteEntryHeader(Entry As libarchive.ArchiveEntry)
		  Super.WriteEntryHeader(Entry)
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Encryption"
			Group="Behavior"
			Type="String"
			InheritedFrom="libarchive.ArchiveWriter"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsOpen"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libarchive.Archive"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Password"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="libarchive.ArchiveWriter"
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
