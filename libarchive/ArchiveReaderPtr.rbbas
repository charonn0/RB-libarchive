#tag Class
Private Class ArchiveReaderPtr
Inherits libarchive.ArchiveReader
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveReader
		  Super.Constructor()
		  SetFormat(ArchiveType)
		  SetFilter(Compressor)
		  OpenFile(File, CHUNK_SIZE)
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
