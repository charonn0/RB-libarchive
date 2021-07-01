#tag Class
Protected Class RawReader
Inherits libarchive.ArchiveReader
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveReader
		  Super.Constructor()
		  SetFormat(ArchiveType.Raw)
		  SetFilter(Compressor)
		  mSourceFile = File
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveReader
		  Super.Constructor()
		  SetFormat(ArchiveType.Raw)
		  SetFilter(Compressor)
		  mSourceBuffer = Buffer
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Count As Integer) As String
		  If Count <= mReadBuffer.LenB Then
		    ' the buffer has enough bytes already
		    Dim data As String = LeftB(mReadBuffer, Count)
		    Dim sz As Integer = mReadBuffer.LenB - Count
		    mReadBuffer = RightB(mReadBuffer, sz)
		    Return data
		  Else
		    ' not enough bytes in the buffer
		    Do Until mReadBuffer.LenB >= Count
		      Dim block As MemoryBlock = Me.ReadEntryDataBlock(CHUNK_SIZE)
		      If block = Nil Or block.Size <= 0 Then
		        mEOF = True
		        block = mReadBuffer
		        mReadBuffer = ""
		        Return block
		      Else
		        mReadBuffer = mReadBuffer + block.StringValue(0, block.Size)
		      End If
		    Loop
		    Return Me.Read(Count)
		  End If
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mEOF
			End Get
		#tag EndGetter
		EOF As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mEOF As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReadBuffer As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="CanDecryptData"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libarchive.ArchiveReader"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CanDecryptMetadata"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libarchive.ArchiveReader"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasEncryptedEntries"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libarchive.ArchiveReader"
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
			InheritedFrom="libarchive.ArchiveReader"
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
