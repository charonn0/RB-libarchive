#tag Class
Private Class ArchiveReaderPtr
Inherits libarchive.ArchiveReader
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveReader
		  Super.Constructor()
		  SetFormat(ArchiveType.All)
		  SetFilter(CompressionType.All)
		  mSourceFile = File
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveReader
		  Super.Constructor()
		  SetFormat(ArchiveType.All)
		  SetFilter(CompressionType.All)
		  mSourceBuffer = Buffer
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(ReadFrom As Readable)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveReader
		  Super.Constructor()
		  SetFormat(ArchiveType.All)
		  SetFilter(CompressionType.All)
		  mSourceStream = ReadFrom
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
