#tag Class
Private Class ArchiveReaderPtr
Inherits libarchive.ArchiveReader
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, ArchiveType As libarchive.ArchiveType, CompressionType As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor(ArchiveType As libarchive.ArchiveType, CompressionType As libarchive.CompressionType) -- from ArchiveReader
		  Super.Constructor(ArchiveType, CompressionType)
		  OpenFile(File, CHUNK_SIZE)
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
