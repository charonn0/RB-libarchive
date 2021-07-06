#tag Class
Protected Class RawWriter
Inherits libarchive.ArchiveWriter
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType, CompressionLevel As Int32)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  If CompressionLevel <> 6 Then
		    SetFilterName(Compressor)
		    Me.CompressionLevel = CompressionLevel
		  End If
		  SetFormat(ArchiveType.Raw)
		  SetFilter(Compressor)
		  mSourceFile = File
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType, CompressionLevel As Int32)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  If CompressionLevel <> 6 Then
		    SetFilterName(Compressor)
		    Me.CompressionLevel = CompressionLevel
		  End If
		  SetFormat(ArchiveType.Raw)
		  SetFilter(Compressor)
		  mSourceBuffer = Buffer
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(WriteTo As Writeable, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.Raw)
		  SetFilter(Compressor)
		  mDestinationStream = WriteTo
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteEntryDataBlock(Block As MemoryBlock)
		  If Not mHeaderWritten Then
		    Dim meta As New libarchive.ArchiveEntry(Me)
		    meta.Type = EntryType.File
		    WriteEntryHeader(meta)
		  End If
		  Super.WriteEntryDataBlock(Block)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteEntryFinished()
		  Super.WriteEntryFinished()
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
