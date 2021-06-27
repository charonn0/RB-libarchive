#tag Class
Protected Class TARReader
Inherits libarchive.ArchiveReader
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor(ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType) -- from ArchiveReader
		  Super.Constructor(ArchiveType.TAR, Compressor)
		  OpenFile(File, CHUNK_SIZE)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor(ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType) -- from ArchiveReader
		  Super.Constructor(ArchiveType.TAR, Compressor)
		  OpenMemory(Buffer)
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = CHUNK_SIZE, Type = Double, Dynamic = False, Default = \"16384", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
