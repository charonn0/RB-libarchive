#tag Class
Protected Class ZipSeekWriter
Inherits libarchive.Writers.ZipWriter
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.ZipSeekable)
		  SetFilter(Compressor)
		  mLastError = archive_write_zip_set_compression_deflate(mArchive)
		  mSourceFile = File
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.ZipSeekable)
		  SetFilter(Compressor)
		  mLastError = archive_write_zip_set_compression_deflate(mArchive)
		  mSourceBuffer = Buffer
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(WriteTo As Writeable, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.ZipSeekable)
		  SetFilter(Compressor)
		  If WriteTo IsA BinaryStream Then BinaryStream(WriteTo).LittleEndian = True
		  mDestinationStream = WriteTo
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Compressed"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libarchive.Writers.ZipWriter"
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
		#tag ViewProperty
			Name="VerifyChecksums"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libarchive.Writers.ZipWriter"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Zip64"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libarchive.Writers.ZipWriter"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
