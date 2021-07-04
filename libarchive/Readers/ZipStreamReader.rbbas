#tag Class
Protected Class ZipStreamReader
Inherits libarchive.Readers.ZipReader
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveReader
		  Super.Constructor()
		  SetFormat(ArchiveType.ZipStreamable)
		  SetFilter(Compressor)
		  mSourceFile = File
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveReader
		  Super.Constructor()
		  SetFormat(ArchiveType.ZipStreamable)
		  SetFilter(Compressor)
		  mSourceBuffer = Buffer
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(ReadFrom As Readable, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveReader
		  Super.Constructor()
		  SetFormat(ArchiveType.ZipStreamable)
		  SetFilter(Compressor)
		  If ReadFrom IsA BinaryStream Then BinaryStream(ReadFrom).LittleEndian = True
		  mSourceStream = ReadFrom
		End Sub
	#tag EndMethod


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
